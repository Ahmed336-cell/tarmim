// UI Widget
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';

import '../../../core/commons/custom_button.dart';
import '../../cart/data/model/cart_item.dart';
import '../../cart/presentation/manager/cart_cubit.dart';
import '../../home/data/model/product.dart';
import 'manager/details_cubit.dart';
import 'manager/details_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsMobile extends StatelessWidget {
  final Product product;
  const ProductDetailsMobile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(product),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            final cubit = context.read<ProductDetailsCubit>();
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl:state.selectedImage,
                            fit: BoxFit.fill,
                            height: 400,
                            width: 400,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: product.product_images!.map((image) {
                            return GestureDetector(
                              onTap: () => cubit.selectImage(image),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: state.selectedImage == image ? Colors.blue : Colors.transparent,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child:CachedNetworkImage(imageUrl: image, fit: BoxFit.cover, width: 80, height: 80),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.product_category, style: TextStyle(fontSize: 16, color: Colors.black)),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(product.product_name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                  Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.add), onPressed: cubit.increaseQuantity),
                                      Text('${state.quantity}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      IconButton(icon: Icon(Icons.remove), onPressed: cubit.decreaseQuantity),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('${product.product_price} ${AppLocalizations.of(context)!.egp}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(AppLocalizations.of(context)!.description, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(product.product_description, style: TextStyle(fontSize: 16)),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        text: AppLocalizations.of(context)!.addCart,
                        onPressed: () {
                          final item = CartItem(
                            id: product.id!,
                            name: product.product_name,
                            image: product.product_images!.first,
                            basePrice: product.product_price,
                            quantity: state.quantity,
                          );
                          context.read<CartCubit>().addItemToCart(item,context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.addedToCart),
                          action: SnackBarAction(label: AppLocalizations.of(context)!.cart, onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartRespo(),));
                          },),
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
