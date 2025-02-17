import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/commons/custom_button.dart';
import '../../cart/data/model/cart_item.dart';
import '../../cart/presentation/cart_respo.dart';
import '../../cart/presentation/manager/cart_cubit.dart';
import '../../home/data/model/product.dart';
import 'manager/details_cubit.dart';
import 'manager/details_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsWeb extends StatelessWidget {
  const ProductDetailsWeb({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit(product),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(state.selectedImage, fit: BoxFit.contain, width: 300, height: 400,
                      headers: {'Access-Control-Allow-Origin': '*'},
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.product.product_category, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.product.product_name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                            Column(
                              children: [
                                ElevatedButton(onPressed: cubit.increaseQuantity, child: const Icon(Icons.add)),
                                Text('${state.quantity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ElevatedButton(onPressed: cubit.decreaseQuantity, child: const Icon(Icons.remove)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(AppLocalizations.of(context)!.price, style: TextStyle(fontSize: 18, color: Colors.black)),
                            Text('${state.product.product_price} ${AppLocalizations.of(context)!.egp}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 32),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 16, mainAxisSpacing: 16),
                          itemCount: state.product.product_images?.length,
                          itemBuilder: (context, index) {
                            String imageUrl = state.product.product_images![index];
                            return GestureDetector(
                              onTap: () => cubit.selectImage(imageUrl),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: state.selectedImage == imageUrl ? Colors.blue : Colors.transparent, width: 3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(imageUrl, fit: BoxFit.fill, width: 50, height: 50),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                         Text(AppLocalizations.of(context)!.description, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(state.product.product_description, style: const TextStyle(fontSize: 16, color: Colors.black)),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: AppLocalizations.of(context)!.addCart,
                          onPressed: () {
                            final item = CartItem(
                              id: state.product.id!,
                              name: state.product.product_name,
                              image: state.product.product_images!.first,
                              basePrice: state.product.product_price,
                              quantity: state.quantity,
                            );
                            context.read<CartCubit>().addItemToCart(item,context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.addedToCart),
                              action: SnackBarAction(label: AppLocalizations.of(context)!.cart, onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartRespo(),));
                              },),
                            ));                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
