import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/home/data/model/product.dart';

import '../../cart/data/model/cart_item.dart';
import '../../cart/presentation/manager/cart_cubit.dart';

class ProductDetailsMobile extends StatefulWidget {
  const ProductDetailsMobile({super.key, required this.product});
  final Product product;

  @override
  _ProductDetailsMobileState createState() => _ProductDetailsMobileState();
}

class _ProductDetailsMobileState extends State<ProductDetailsMobile> {
  int _quantity = 1; // Default quantity set to 1
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.product.product_images!.first; // Initialize with the first image
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                // Main Product Image
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Image.network(
                      _selectedImage,
                      fit: BoxFit.fill,
                      height: 400,
                      width: 400,
                    ),
                  ),
                ),
                // Product Details Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      widget.product.product_images?.length ?? 0,
                          (index) {
                        String imageUrl = widget.product.product_images![index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImage = imageUrl;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _selectedImage == imageUrl ? Colors.blue : Colors.transparent,
                                width: 5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.product.product_images![index],
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                        Text(
                          widget.product.product_category,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.product_name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.brown),
                                  ),
                                  onPressed: _increaseQuantity,
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                                Text(
                                  '$_quantity',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.brown),
                                  ),
                                  onPressed: _decreaseQuantity,
                                  child: Icon(Icons.remove, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.product.product_price} EGP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Description',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.product.product_description,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                CustomButton(
                  text: "Add to Cart",
                  onPressed: () {
                    // Handle add to cart action
                    final item = CartItem(
                      id: widget.product.id! ,
                      name: widget.product.product_name,
                      image: widget.product.product_images!.first,
                      basePrice: widget.product.product_price,
                      quantity: _quantity,
                    );
                    context.read<CartCubit>().addItemToCart(item); // Adding item to the cart
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart')));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
