import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarmim/core/commons/custom_button.dart';

class ProductDetailsMobile extends StatelessWidget {
  const ProductDetailsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          InkWell(child: SvgPicture.asset('assets/images/cart.svg' , width: 50, height: 60,),
          onTap: (){},
          ),

        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                // Main Product Image
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Image.asset(
                      'assets/images/elicit.png', // Replace with actual product image URL
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                ),
                // Product Details Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      4,
                          (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/elicit.png', // Replace with actual thumbnail URLs
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notebook",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Ramadan Notebook',
                          style: TextStyle(
                            fontSize: 24,
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // Small Images
                        SizedBox(height: 8,),
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
                      ],
                    ),
                  ),
                ),

               CustomButton(text: "Add to Cart", onPressed: (){})
              ],
            ),
          )
        ],

      ),
    );
  }
}


