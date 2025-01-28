import 'package:flutter/material.dart';
class CartItemMobile extends StatelessWidget {
  const CartItemMobile({super.key, required this.image, required this.title, required this.brand, required this.price, required this.quantity});
  final String image;
  final String title;
  final String brand;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:  Image.asset(
                image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Product Details
             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    brand,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$price EGP',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            // Quantity Controls
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    // Increase quantity
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
                 Text(quantity.toString()),
                 IconButton(
                  onPressed: () {
                    // Decrease quantity
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            ),
            // Remove Button
             IconButton(
              onPressed: () {
                // Remove item
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
