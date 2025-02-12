import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/cart_item.dart';
import '../../data/repo/cart_repo.dart';
import 'cart_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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

  Future<void> loadCart(BuildContext context) async {
    emit(CartLoading());
    try {
      final items = await cartRepository.fetchCartItems();
      double total = items.fold(0, (sum, item) => sum + item.totalPrice);
      emit(CartLoaded(items: items, totalPrice: total));
    } catch (e) {
      emit(CartError(message: AppLocalizations.of(context)!.faildToLoadcart));
    }
  }

  Future<void> updateItemQuantity(CartItem item, int quantity, BuildContext context) async {
    item.quantity = quantity;
    await cartRepository.updateCartItem(item);
    loadCart(context); // Refresh cart
  }

  Future<void> removeCartItem(int id, BuildContext context) async {
    await cartRepository.removeCartItem(id);
    loadCart(context);
  }



  Future<void> addItemToCart(CartItem item , BuildContext context) async {
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
        emit(CartError(message: AppLocalizations.of(context)!.faildToAddToCart));
      }
    }
  }

  Future<void> updateLocation(
      String name,
      String country,
      String email,
      String gov,
      String city,
      String address,
      String phoneNumber) async {

    this.name = name;
    this.country = country;
    this.city = city;
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.email = email;

    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      double itemsTotal = currentState.items.fold(0, (sum, item) => sum + item.basePrice);

      this.gov = gov;

      double newShippingCost = getShippingCost(gov);

      if (currentState.totalPrice == itemsTotal + newShippingCost) {
        return;
      }

      double newTotal = itemsTotal + newShippingCost;



      emit(CartLoaded(items: currentState.items, totalPrice: newTotal));
    }
  }




  /// Returns the shipping cost based on the state/governorate.
  double getShippingCost(String? gov) {


    Map<String, double> shippingCosts = {
      "القاهره": 45,
      "الجيزه": 45,
      "الدقهلية": 55,
      "الغربية": 55,
      "الشرقية": 55,
      "المنوفية": 55,
      "كفر الشيخ": 55,
      "البحيرة": 55,
      "بورسعيد": 55,
      "الإسماعيلية": 55,
      "السويس": 55,
      "الإسكندرية": 55,
      "الغردقة": 80,
      "الوادي": 80,
      "مطروح": 80,
      "شرم الشيخ": 95,
      "العين السخنه": 95,
      "بني سويف": 65,
      "المنيا": 65,
      "أسيوط": 65,
      "سوهاج": 65,
      "قنا": 65,
      "الأقصر": 65,
      "أسوان": 65,
      "البحر الأحمر": 65,
    };

    double cost = shippingCosts[gov] ?? 0;
    print("Shipping cost found: $cost"); // Debugging
    return cost;
  }



  Future<void> applyPromoCode(String promoCode,BuildContext context) async {
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
        emit(CartError(message: AppLocalizations.of(context)!.invalidPromoCode)); // Show specific error message
      }
    }
  }
  Future<void> placeOrder(BuildContext context) async {
    if ([name, country, gov, city, address, phoneNumber, email].contains(null)) {
      emit(CartError(message: AppLocalizations.of(context)!.pleasFill));
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
        emit(CartError(message: AppLocalizations.of(context)!.faildToPlaceOrder));
      }
    }
  }}
