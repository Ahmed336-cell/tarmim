import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';

class ProductDetailsMobile extends StatefulWidget {
  const ProductDetailsMobile({super.key});

  @override
  _ProductDetailsMobileState createState() => _ProductDetailsMobileState();
}

class _ProductDetailsMobileState extends State<ProductDetailsMobile> {
  int _quantity = 1; // Default quantity set to 1

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
                    child: Image.asset(
                      'assets/images/elicit.png', // Replace with actual product image URL
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                ),
                // Product Details Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      4,
                          (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/elicit.png', // Replace with actual thumbnail URLs
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
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
                          "Notebook",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ramadan Notebook',
                              style: TextStyle(
                                fontSize: 24,
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
                                  child: Icon(Icons.add, color: Colors.white,),
                                ),
                                Text(
                                  '$_quantity',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.brown),
                                  ),
                                  onPressed: _decreaseQuantity,
                                  child: Icon(Icons.remove, color: Colors.white,),
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
                              '120 EGP',
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'adasdas asdasdbaksdba asfbasblfab asaslnflasfnaf alsnfalsfnflas ',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        // Quantity Selector

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                CustomButton(
                  text: "Add to Cart",
                  onPressed: () {
                    // Handle add to cart action
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
