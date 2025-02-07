import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarmim/features/home/data/repo/home_repo.dart';
import 'package:tarmim/features/home/presentation/manager/home_state.dart';





class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _getProductRepository;

  HomeCubit(this._getProductRepository) : super(ProductListInitial());
  void searchProducts(String query) async{
    final products = await _getProductRepository.fetchProducts();

    if (query.isEmpty) {
      emit(ProductListSuccess( products: products)); // Show all products if search is empty
    } else {
      final filteredProducts = products
          .where((product) =>
          product.product_name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ProductListSuccess(products: filteredProducts));
    }
  }

  void fetchProducts() async {
    emit(ProductListLoading());
    try {
      final products = await _getProductRepository.fetchProducts();
      emit(ProductListSuccess(products: products));
    } catch (e) {
      emit(ProductListFailure(message: e.toString()));
    }
  }
}