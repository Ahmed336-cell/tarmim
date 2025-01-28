import 'package:flutter/material.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_respo.dart';
import 'package:tarmim/features/details/presentation/details_respo.dart';
import 'package:tarmim/features/home/presentation/home_respo.dart';
import 'package:tarmim/features/home/presentation/home_web.dart';
import 'package:tarmim/features/main_navigation/main_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainWeb(),
    );
  }
}
