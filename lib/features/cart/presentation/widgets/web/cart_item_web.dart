import 'package:flutter/material.dart';

class CartItemWeb extends StatelessWidget {
  const CartItemWeb({super.key, required this.image, required this.title, required this.brand, required this.price, required this.quantity});
  final String image;
  final String title;
  final String brand;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return   Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    brand,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$price EGP',
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Quantity Controls
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    // Increase quantity
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    // Decrease quantity
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // Decrease quantity
              },
              icon: const Icon(Icons.delete,color: Colors.red,),
            ),
          ],
        ),
      ),
    );
  }
}
