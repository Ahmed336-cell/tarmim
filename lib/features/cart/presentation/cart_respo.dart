import 'package:flutter/material.dart';
import 'package:tarmim/features/cart/presentation/cart_mobile.dart';
import 'package:tarmim/features/cart/presentation/cart_web.dart';

import '../../../constants.dart';
class CartRespo extends StatelessWidget {
  const CartRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(

            body: const CartWeb(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(Constant.color),
              centerTitle: true,
              title: const Text(
                'Cart',
                style: TextStyle(fontSize: 24,color: Colors.brown, fontWeight: FontWeight.bold),
              ),
            ),
            body: const CartMobile(),
          );
        }
      },
    );
  }
}
