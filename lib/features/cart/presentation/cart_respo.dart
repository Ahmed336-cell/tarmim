import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarmim/features/cart/presentation/cart_mobile.dart';
import 'package:tarmim/features/cart/presentation/cart_web.dart';

import '../../../constants.dart';
import '../data/repo/cart_repo.dart';
import 'manager/cart_cubit.dart';
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

            body:  CartMobile(),
          );
        }
      },
    );
  }
}
