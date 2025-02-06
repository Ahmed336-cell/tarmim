// State classes
import 'package:equatable/equatable.dart';

import '../../data/model/product.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends HomeState {}

class ProductListLoading extends HomeState {}

class ProductListSuccess extends HomeState {
  final List<Product> products;

  const ProductListSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductListFailure extends HomeState {
  final String message;

  const ProductListFailure({required this.message});

  @override
  List<Object> get props => [message];
}