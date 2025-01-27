import 'package:flutter/material.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_mobile.dart';
class DeliveryWeb extends StatelessWidget {
  const DeliveryWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 600),
        child:  DeliveryMobile(), // Reuse the mobile form
      ),
    );
  }
}