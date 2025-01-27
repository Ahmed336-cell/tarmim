import 'package:flutter/material.dart';

class CartMobile extends StatelessWidget {
  const CartMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Your Cart' , style: TextStyle(fontSize: 24,color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items
            Expanded(
              child: ListView(
                children: [
                  _buildCartItem(
                    image: 'assets/images/elicit.png',
                    title: "Ramadan Notebook",
                    brand: 'Notebook',
                    price: 200,

                    quantity: 1,
                  ),
                  const SizedBox(height: 10),
                  _buildCartItem(
                    image: 'assets/images/elicit.png',
                    title: "Men's Tie-Dye T-Shirt",
                    brand: 'Nike Sportswear',
                    price: 45,

                    quantity: 1,
                  ),
                ],
              ),
            ),
            // Delivery Address
            const ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text('Giza, Hawamdia 2, Building 5, Floor 3'),
              subtitle: Text('Sylhet'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            const Divider(),
            // Payment Method

            // Order Info
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _OrderInfoRow(label: 'Subtotal', value: '110 EGP'),
                  _OrderInfoRow(label: 'Shipping cost', value: '10 EGP' ),
                  _OrderInfoRow(label: 'Total', value: '120 EGP'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Checkout Button
            MaterialButton(onPressed: (){},
              color: Colors.blue.shade900,
              minWidth: double.infinity,
              height: 60,
              child: Text('Checkouts', style: TextStyle(color: Colors.white, fontSize: 20),),

            )
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem({
    required String image,
    required String title,
    required String brand,
    required double price,
    required int quantity,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
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
  class _OrderInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _OrderInfoRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label , style: const TextStyle(color: Colors.black ,fontSize: 18 , fontWeight: FontWeight.bold)),
          Text(
            value,
            style: TextStyle(fontWeight:   FontWeight.bold , fontSize: 16),
          ),
        ],
      ),
    );
  }
}
