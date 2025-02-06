import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/cart_item.dart';

class CartRepository {
  final SupabaseClient supabase = Supabase.instance.client;
  final List<CartItem> _cartItems = [];

  Future<List<CartItem>> fetchCartItems() async {
    return List.from(_cartItems); // Return a copy of the list
  }

  Future<void> removeCartItem(int id) async {
    _cartItems.removeWhere((item) => item.id == id);
  }

  // Clear the cart after order submission
  Future<void> clearCart() async {
    _cartItems.clear();
  }

  Future<void> updateCartItem(CartItem item) async {
    int index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      _cartItems[index] = item;
    }
  }

  Future<Map<String, dynamic>?> validatePromoCode(String promoCode) async {
    try {
      final response = await supabase
          .from('promo_codes')
          .select()
          .eq('code', promoCode)
          .eq('is_active', true)
          .single();

      if (response != null) {
        final now = DateTime.now();
        final startDate = response['start_date'] != null
            ? DateTime.parse(response['start_date'])
            : null;
        final endDate = response['end_date'] != null
            ? DateTime.parse(response['end_date'])
            : null;
        final usedCount = response['used_count'] ?? 0;
        final maxUsers = response['max_users'];

        // Check if promo code is based on date range
        if (startDate != null && endDate != null) {
          final isDateRangeValid = now.isAfter(startDate) && now.isBefore(endDate);
          if (!isDateRangeValid) {
            print("Promo code is expired or not yet active.");
            throw Exception("Promo code is expired or not yet active.");
          }
        }

        // Check if promo code is ba on user limit
        if (maxUsers != null) {
          final isUsageValid = usedCount < maxUsers;
          if (!isUsageValid) {
            throw Exception("Promo code has reached its maximum usage limit.");
          }
        }

        // If both conditions are valid (or not applicable), return the promo code data
        return response;
      }
      return null; // Promo code is invalid
    } catch (e) {
      throw Exception("Failed to validate promo code: ${e.toString()}");
    }
  }

  Future<void> incrementPromoCodeUsage(String promoCode) async {
    await supabase
        .from('promo_codes')
        .update({'used_count': supabase.from('promo_codes').select('used_count').single().then((value) => value['used_count'] + 1)})
        .eq('code', promoCode)
        .single();
  }

  Future<double> getLocationBasedPrice(double basePrice, String country, String state, String city) async {
    final response = await supabase
        .from('location_pricing')
        .select()
        .eq('country', country)
        .eq('state', state)
        .eq('city', city)
        .single();

    if (response != null) {
      return basePrice * response['multiplier'].toDouble(); // Example: Different price multipliers for locations
    }
    return basePrice; // Default if location not found
  }

  Future<void> addCartItem(CartItem item) async {
    int index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      _cartItems[index].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }
  }

  Future<void> submitOrder(Order order) async {
    // Insert into the "orders" table using the columns from `order.toMap()`
    await supabase.from('orders').insert(order.toMap());
    // Clear the cart after submission if you like
    await clearCart();
  }
}