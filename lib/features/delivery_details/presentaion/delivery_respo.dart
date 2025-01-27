import 'package:flutter/material.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_mobile.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_web.dart';

class DeliveryRespo extends StatelessWidget {
  const DeliveryRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade900,
              centerTitle: true,
              title: const Text(
                'Address',
                style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: const DeliveryWeb(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade900,
              centerTitle: true,
              title: const Text(
                'Address',
                style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body:  DeliveryMobile(),
          );
        }
      },
    );
  }
}


