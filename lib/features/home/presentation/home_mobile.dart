import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarmim/features/home/presentation/widgets/mobile/product_card_mobile.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap everything in SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/log.png",
                    width: 100,
                    height: 100,
                  ),
                  InkWell(
                    child: SvgPicture.asset(
                      'assets/images/cart.svg',
                      width: 40, // Adjust size
                      height: 40,
                    ),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Product Grid
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey[200],
                    child: GridView.builder(
                      shrinkWrap: true, // Allow the GridView to size itself
                      physics: const NeverScrollableScrollPhysics(), // Prevent independent scrolling
                      itemCount: 12, // Number of items in the grid
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductCardMobile(
                              title: 'Product Name',
                              price: '\$45.00',
                              imageUrl: 'assets/images/elicit.png', // Placeholder image
                              backgroundColor: Colors.blue.shade900,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
