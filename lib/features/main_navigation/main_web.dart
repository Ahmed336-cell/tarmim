import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarmim/features/aboutus/presentation/about_us.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/home/presentation/home_respo.dart';
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
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = [
    const HomeRespo(),
    AboutUsScreen(),
    const CartRespo(),
  ];

  final List<String> _titles = ['Home', 'About Us', 'Cart'];

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ValueListenableBuilder<int>(
          valueListenable: _selectedIndex,
          builder: (context, index, _) {
            return AppBar(
              backgroundColor: Color(Constant.color),
              centerTitle: true,
              title: Text(
                _titles[index],
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Navigation Bar
          WebNavigationBar(
            onItemSelected: (index) => _selectedIndex.value = index,
            selectedIndex: _selectedIndex,
          ),
          // Page Content
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: _selectedIndex,
              builder: (context, index, _) {
                return IndexedStack(
                  index: index,
                  children: _pages,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Extracted Navigation Bar Widget for better maintainability
class WebNavigationBar extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final Function(int) onItemSelected;

  const WebNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              _navItem('Home', 0),
              _navItem('About Us', 1),
              InkWell(
                child: SvgPicture.asset(
                  'assets/images/cart.svg',
                  width: 40,
                  height: 40,
                ),
                onTap: () => onItemSelected(2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(String label, int index) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, selected, _) {
        final isSelected = selected == index;
        return TextButton(
          onPressed: () => onItemSelected(index),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
}
