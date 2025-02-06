import 'package:flutter/material.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_mobile.dart';
class DeliveryWeb extends StatelessWidget {
  const DeliveryWeb({Key? key, required this.totalPrice}) : super(key: key);
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 600),
        child:  DeliveryMobile(initialTotalPrice: totalPrice,), // Reuse the mobile form
      ),
    );
  }
}