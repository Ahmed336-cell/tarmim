// State class for product details
import '../../../home/data/model/product.dart';

class ProductDetailsState {
final Product product;
final String selectedImage;
final int quantity;

ProductDetailsState({required this.product, required this.selectedImage, required this.quantity});

ProductDetailsState copyWith({String? selectedImage, int? quantity}) {
  return ProductDetailsState(
    product: product,
    selectedImage: selectedImage ?? this.selectedImage,
    quantity: quantity ?? this.quantity,
  );
}
}