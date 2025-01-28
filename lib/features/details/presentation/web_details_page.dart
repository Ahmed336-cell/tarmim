import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/commons/custom_button.dart';
class ProductDetailsWeb extends StatelessWidget {
  const ProductDetailsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        actions: [
          InkWell(child: SvgPicture.asset('assets/images/cart.svg' , width: 50, height: 60,),
          onTap: (){},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Product Image
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'assets/images/elicit.png', // Replace with actual product image URL
                  fit: BoxFit.contain,
                  width: 300,
                  height: 400,
                ),
              ),
            ),
            SizedBox(width: 32),
            // Product Details Section
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notebook",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ramadan Notebook',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        '120 EGP',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  // Thumbnail Images
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/elicit.png', // Replace with actual thumbnails
                          fit: BoxFit.fill,
                          width: 30,
                          height: 30,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16,),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'adasdas asdasdbaksdba asfbasblfab asaslnflasfnaf alsnfalsfnflas ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height:24 ,),
                  CustomButton(text: "Add to Cart", onPressed: (){})

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
