import 'package:flutter/material.dart';
import 'package:tarmim/features/home/data/model/product.dart';

import '../../../core/commons/custom_button.dart';

class ProductDetailsWeb extends StatefulWidget {
  const ProductDetailsWeb({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsWeb> createState() => _ProductDetailsWebState();
}

class _ProductDetailsWebState extends State<ProductDetailsWeb> {
  int _quantity = 1; // Default quantity set to 1
  late String _selectedImage; // Track the selected image

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Product Image
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  _selectedImage, // Display the selected image
                  fit: BoxFit.contain,
                  width: 300,
                  height: 400,
                ),
              ),
            ),
            const SizedBox(width: 32),
            // Product Details Section
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.product_category,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.product_name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.brown),
                            ),
                            onPressed: _increaseQuantity,
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.brown),
                            ),
                            onPressed: _decreaseQuantity,
                            child: const Icon(Icons.remove, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        '${widget.product.product_price} EGP',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Thumbnail Images
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: widget.product.product_images?.length,
                    itemBuilder: (context, index) {
                      String imageUrl = widget.product.product_images![index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = imageUrl; // Update main image
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedImage == imageUrl ? Colors.blue : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.fill,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.product.product_description,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(text: "Add to Cart", onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
