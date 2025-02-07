import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/cart_item.dart';
import '../../data/repo/cart_repo.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartCubit(this.cartRepository) : super(CartInitial());
  String ? name;
  String? country;
  String? gov;
  String? city;
  String? address;
  String? phoneNumber;
  String? email;
  String promoCode="";

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final items = await cartRepository.fetchCartItems();
      double total = items.fold(0, (sum, item) => sum + item.totalPrice);
      emit(CartLoaded(items: items, totalPrice: total));
    } catch (e) {
      emit(CartError(message: "Failed to load cart"));
    }
  }

  Future<void> updateItemQuantity(CartItem item, int quantity) async {
    item.quantity = quantity;
    await cartRepository.updateCartItem(item);
    loadCart(); // Refresh cart
  }

  Future<void> removeCartItem(int id) async {
    await cartRepository.removeCartItem(id);
    loadCart();
  }



  Future<void> addItemToCart(CartItem item) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      List<CartItem> updatedCart = List.from(currentState.items);

      // Check if item already exists
      int existingIndex = updatedCart.indexWhere((cartItem) => cartItem.id == item.id);
      if (existingIndex != -1) {
        updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
          quantity: updatedCart[existingIndex].quantity + item.quantity,
        );
      } else {
        updatedCart.add(item);
      }

      try {
        await cartRepository.addCartItem(item);
        double total = updatedCart.fold(0, (sum, item) => sum + item.totalPrice);
        emit(CartLoaded(items: updatedCart, totalPrice: total));
      } catch (e) {
        emit(CartError(message: "Failed to add item to cart"));
      }
    }
  }

  Future<void> updateLocation(
      String name,         // <-- accept name from UI
      String country,
      String email,
      String gov,
      String city,
      String address,
      String phoneNumber
      ) async {
    this.name = name;
    this.country = country;
    this.gov = gov;
    this.city = city;
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.email = email;

    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      double total = 0;
      for (var item in currentState.items) {
        total += await cartRepository.getLocationBasedPrice(
          item.basePrice,
          country,
          gov,
          city,
        ) * item.quantity;
      }
      emit(CartLoaded(items: currentState.items, totalPrice: total));
    }
  }
  /// Returns the shipping cost based on the state/governorate.
  double getShippingCost(String gov) {
    Map<String, double> shippingCosts = {
      "Cairo": 50.0,
      "al-Jizah": 40.0,
      "Alexandria": 60.0,
      "Aswan": 80.0,
      "Luxor": 70.0,
    };

    return shippingCosts[gov] ?? 100.0; // Default shipping cost if state is unknown
  }

  Future<void> applyPromoCode(String promoCode) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      try {
        final promoData = await cartRepository.validatePromoCode(promoCode);
        if (promoData != null) {
          final discountPercentage = promoData['discount_percentage'] as int;
          double discountedTotal = currentState.totalPrice * (1 - discountPercentage / 100);
          this.promoCode = promoCode; // Store applied promo code
          emit(CartLoaded(items: currentState.items, totalPrice: discountedTotal));
        }
      } catch (e) {
        emit(CartError(message: "Invalid promo code")); // Show specific error message
      }
    }
  }
  Future<void> placeOrder() async {
    if ([name, country, gov, city, address, phoneNumber, email].contains(null)) {
      emit(CartError(message: "Please fill in all required fields before placing an order"));
      return;
    }

    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      double shippingCost = getShippingCost(gov!);
      double finalPrice = currentState.totalPrice + shippingCost;

      final order = Order(
        items: currentState.items,
        name: name!,
        country: country!,
        state: gov!,
        city: city!,
        address: address!,
        phoneNumber: phoneNumber!,
        totalPrice: finalPrice,
        email: email!,
        promoCode: promoCode, // Include promo code in the order
      );

      try {
        await cartRepository.submitOrder(order);

        // Increment promo code usage if applied
        if (promoCode.isNotEmpty) {
          await cartRepository.incrementPromoCodeUsage(promoCode);
        }

        // Reset fields after order placement
        name = country = gov = city = address = phoneNumber = email = "";
        promoCode = ""; // Clear promo code

        emit(CartLoaded(items: [], totalPrice: 0)); // Clear cart
      } catch (e) {
        emit(CartError(message: "Failed to place order. Please try again later."));
      }
    }
  }}
