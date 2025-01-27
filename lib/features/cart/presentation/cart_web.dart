import 'package:flutter/material.dart';

class CartWeb extends StatelessWidget {
  const CartWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWideScreen = constraints.maxWidth > 800;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Items Section
                Expanded(
                  flex: 3,
                  child: ListView(
                    children: [
                      _buildCartItem(
                        image: 'assets/images/elicit.png',
                        title: "Ramadan Notebook",
                        brand: 'Notebook',
                        price: 200,
                        quantity: 1,
                      ),
                      _buildCartItem(
                        image: 'assets/images/elicit.png',
                        title: "Ramadan Notebook",
                        brand: 'Notebook',
                        price: 200,
                        quantity: 1,
                      ),
                      const SizedBox(height: 16),
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
                if (isWideScreen) const SizedBox(width: 24),
                // Summary Section
                Expanded(
                  flex: isWideScreen ? 2 : 3,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Delivery Address
                        const ListTile(
                          leading: Icon(Icons.location_on, color: Colors.blue, size: 28),
                          title: Text(
                            'Giza, Hawamdia 2, Building 5, Floor 3',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Egypt', style: TextStyle(fontSize: 16)),
                          trailing: Icon(Icons.check_circle, color: Colors.green),
                        ),
                        const Divider(height: 24),
                        // Payment Method

                        // Order Info
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _OrderInfoRow(label: 'Subtotal', value: '110 EGP'),
                              _OrderInfoRow(label: 'Shipping cost', value: '10 EGP'),
                              _OrderInfoRow(label: 'Total', value: '120 EGP'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Checkout Button
                        MaterialButton(
                          onPressed: () {
                            // Navigate to checkout
                          },
                          color: Colors.blue.shade900,
                          minWidth: double.infinity,
                          height: 60,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
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
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
