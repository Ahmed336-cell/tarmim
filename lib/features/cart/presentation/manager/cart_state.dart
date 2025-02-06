import 'package:equatable/equatable.dart';

import '../../data/model/cart_item.dart';

abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalPrice;
  final double shippingCost;

  CartLoaded({
    required this.items,
    required this.totalPrice,
    this.shippingCost = 0,
  });

  @override
  List<Object?> get props => [items, totalPrice, shippingCost];
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});

  @override
  List<Object?> get props => [message];
}