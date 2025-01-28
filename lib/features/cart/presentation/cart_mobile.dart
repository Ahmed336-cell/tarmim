import 'package:flutter/material.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/cartItemMobile.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/orderInfo.dart';

class CartMobile extends StatelessWidget {
  const CartMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Your Cart', style: TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
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
                  CartItemMobile(
                    image: 'assets/images/elicit.png',
                    title: "Ramadan Notebook",
                    brand: 'Notebook',
                    price: 200,

                    quantity: 1,
                  ),
                  const SizedBox(height: 10),
                  CartItemMobile(
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
                  OrderInfoRowMobile(label: 'Subtotal', value: '110 EGP'),
                  OrderInfoRowMobile(label: 'Shipping cost', value: '10 EGP'),
                  OrderInfoRowMobile(label: 'Total', value: '120 EGP'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Checkout Button
            CustomButton(text: "Checkout", onPressed: () {})
          ],
        ),
      ),
    );
  }
}



