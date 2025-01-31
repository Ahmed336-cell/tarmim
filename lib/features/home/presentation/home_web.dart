import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarmim/features/details/presentation/details_respo.dart';
import 'package:tarmim/features/home/presentation/widgets/mobile/product_card_web.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navbar

            // Content
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Product Grid
                  GridView.builder(
                    shrinkWrap: true, // Ensures the grid height adjusts to content
                    physics: const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling independently
                    itemCount: 8, // Adjust the number of items
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCardWeb(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsRespo()));
                        },
                        title: 'Product ${index + 1}',
                        price: '\$45.00',
                        imageUrl: 'assets/images/elicit.png', // Placeholder images
                      );
                    },
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
