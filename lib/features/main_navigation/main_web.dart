import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarmim/features/aboutus/presentation/about_us.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/details/presentation/details_respo.dart';
import 'package:tarmim/features/home/presentation/home_respo.dart';
import 'package:tarmim/features/main_navigation/web_footer.dart';

import '../../constants.dart';

class MainWeb extends StatelessWidget {
  const MainWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout();
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  int _selectedPage = 0;
  // Pages to navigate between
  final List<Widget> _pages = [
    const HomeRespo(),
    AboutUsScreen(),
    const CartRespo()

  ];
  final List<String>title=[
    'Home',
    'About Us',
    'Cart'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Constant.color),
        centerTitle: true,
        title:  Text(
          title[_selectedPage],
          style: TextStyle(fontSize: 24,color: Colors.brown, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Fixed Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/log.png",
                  width: 100,
                  height: 100,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 0; // Navigate to Home
                          _selectedPage=0;
                        });
                      },
                      child: const Text('Home'),
                    ),

                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 1; // Navigate to Home
                          _selectedPage=1;
                        });
                      },
                      child: const Text('About Us'),
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/images/cart.svg',
                        width: 40,
                        height: 40,
                      ),
                      onTap: () {
                        // Handle Cart action here
                        setState(() {
                          _selectedIndex = 2; // Navigate to Cart
                          _selectedPage=2;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Dynamic Page Content
          Expanded(
            child: _pages[_selectedIndex],
          ),
          // Footer
          WebsiteFooter(),
        ],
      ),
    );
  }
}