import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/cart/data/model/cart_item.dart';
import 'package:tarmim/features/cart/presentation/manager/cart_cubit.dart';
import 'package:tarmim/features/home/data/model/product.dart';

import 'details_state.dart';

// Cubit for managing product details state
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(Product product)
      : super(ProductDetailsState(product: product, selectedImage: product.product_images!.first, quantity: 1));

  void selectImage(String imageUrl) {
    emit(state.copyWith(selectedImage: imageUrl));
  }

  void increaseQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decreaseQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
}