import 'package:flutter/material.dart';
import 'package:tarmim/features/cart/presentation/widgets/web/cart_item_web.dart';
import 'package:tarmim/features/cart/presentation/widgets/web/order_info_web.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_respo.dart';

import '../../../core/commons/custom_button.dart';

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
                      CartItemWeb(
                        image: 'assets/images/elicit.png',
                        title: "Ramadan Notebook",
                        brand: 'Notebook',
                        price: 200,
                        quantity: 1,
                      ),
                      CartItemWeb(
                        image: 'assets/images/elicit.png',
                        title: "Ramadan Notebook",
                        brand: 'Notebook',
                        price: 200,
                        quantity: 1,
                      ),
                      const SizedBox(height: 16),
                      CartItemWeb(
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
                         ListTile(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryRespo()));
                          },
                          leading: Icon(
                              Icons.location_on, color: Colors.blue, size: 28),
                          title: Text(
                            'Giza, Hawamdia 2, Building 5, Floor 3',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'Egypt', style: TextStyle(fontSize: 16)),
                          trailing: Icon(
                              Icons.check_circle, color: Colors.green),
                        ),
                        const Divider(height: 24),
                        // Payment Method
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
                            children: const [
                              OrderInfoRowWeb(
                                  label: 'Subtotal', value: '110 EGP'),
                              OrderInfoRowWeb(
                                  label: 'Shipping cost', value: '10 EGP'),
                              OrderInfoRowWeb(label: 'Total', value: '120 EGP'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Checkout Button
                        CustomButton(text: "Checkout", onPressed: () {})

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
}

