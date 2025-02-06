import 'package:flutter/material.dart';
import 'package:tarmim/constants.dart';
import 'package:tarmim/features/details/presentation/mobile_details_page.dart';
import 'package:tarmim/features/details/presentation/web_details_page.dart';
import 'package:tarmim/features/home/data/model/product.dart';

class DetailsRespo extends StatelessWidget {
  const DetailsRespo({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(

            body:  ProductDetailsWeb(product: product,),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(Constant.color),
              centerTitle: true,
              title: const Text(
                'Details',
                style: TextStyle(fontSize: 24,color: Colors.brown, fontWeight: FontWeight.bold),
              ),
            ),
            body:  ProductDetailsMobile(product: product,),
          );
        }
      },
    );
  }
}
