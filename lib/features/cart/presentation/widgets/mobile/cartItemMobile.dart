import 'package:flutter/material.dart';
class CartItemMobile extends StatefulWidget {
  const CartItemMobile({super.key, required this.image, required this.title, required this.brand, required this.price, required this.quantity, required this.increase, required this.decrease, required this.remove});
  final String image;
  final String title;
  final String brand;
  final double price;
  final int quantity;
  final VoidCallback increase;
  final VoidCallback decrease;
  final VoidCallback remove;

  @override
  State<CartItemMobile> createState() => _CartItemMobileState();
}

class _CartItemMobileState extends State<CartItemMobile> {
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
              child:  Image.network(
                widget.image,
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
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    widget.brand,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.price} EGP',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            // Quantity Controls
            Column(
              children: [
                IconButton(
                  onPressed: widget.increase,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                 Text(widget.quantity.toString()),
                 IconButton(
                  onPressed: widget.decrease,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            ),
            // Remove Button
             IconButton(
              onPressed:widget.remove,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
