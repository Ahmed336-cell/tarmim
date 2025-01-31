import 'package:flutter/material.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/cartItemMobile.dart';
import 'package:tarmim/features/cart/presentation/widgets/mobile/orderInfo.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_respo.dart';

class CartMobile extends StatelessWidget {
  const CartMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // FIX: Prevents overflow when keyboard appears
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cart Items
              SizedBox(
                height: 300, // FIX: Set height to prevent infinite constraints
                child: ListView(
                  shrinkWrap: true, // FIX: Allows ListView inside Column
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
               ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryRespo()));
                },
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text('Giza, Hawamdia 2, Building 5, Floor 3'),
                subtitle: Text('Sylhet'),
                trailing: Icon(Icons.check_circle, color: Colors.green),
              ),
              const Divider(),
              // Promo Code
              Row(
                children: [
                  Expanded(
                    child: TextField(

                      decoration: const InputDecoration(
                        hintText: 'Enter Promo Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded( // FIX: Prevents layout issues
                    child: CustomButton(text: 'Apply', onPressed: () {}),
                  ),
                ],
              ),
              // Order Info
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderInfoRowMobile(label: 'Subtotal', value: '110 EGP'),
                    OrderInfoRowMobile(label: 'Shipping cost', value: '10 EGP'),
                    OrderInfoRowMobile(label: 'Total', value: '120 EGP'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Checkout Button
              CustomButton(text: "Checkout", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
