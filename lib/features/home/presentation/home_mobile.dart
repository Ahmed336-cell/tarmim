import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/log.png" , width: 100, height: 100,),

        backgroundColor: Colors.transparent,
        title: Text('Hello', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

        actions: [
         SvgPicture.asset('assets/images/cart.svg' , width: 50, height: 60,),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            // Product Grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[200],
                child: GridView.builder(
                  itemCount: 4, // Adjust the number of items
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ArchedProductCard(
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
            ),
          ],
        ),
      ),
    );
  }
}

class ArchedProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final Color? backgroundColor;

  const ArchedProductCard({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Arched Container for Image
          Expanded(
            flex: 3,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.grey[300],
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Center(
                child: ClipRRect(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
          ),
          // Product Details
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}