import 'package:flutter/material.dart';
import 'package:tarmim/features/details/presentation/mobile_details_page.dart';
import 'package:tarmim/features/details/presentation/web_details_page.dart';

class DetailsRespo extends StatelessWidget {
  const DetailsRespo({super.key});

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
                'Details',
                style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: const ProductDetailsWeb(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade900,
              centerTitle: true,
              title: const Text(
                'Details',
                style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: const ProductDetailsMobile(),
          );
        }
      },
    );
  }
}
