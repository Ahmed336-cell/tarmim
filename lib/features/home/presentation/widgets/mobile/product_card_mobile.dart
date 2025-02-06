import 'package:flutter/material.dart';
class ProductCardMobile extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final Color? backgroundColor;
  final VoidCallback onTap;
  const ProductCardMobile({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.backgroundColor, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Arched Container for Image
            Expanded(
              flex: 3,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color:  Colors.grey[300],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),
            ),
            // Product Details
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}