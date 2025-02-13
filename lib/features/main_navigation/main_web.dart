import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tarmim/features/aboutus/presentation/about_us.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/home/presentation/home_respo.dart';
import 'package:tarmim/features/main_navigation/web_footer.dart';
import '../../constants.dart';
import 'manager/language_cubit.dart';

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

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.contact,
      AppLocalizations.of(context)!.cart

    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ValueListenableBuilder<int>(
          valueListenable: _selectedIndex,
          builder: (context, index, _) {
            return AppBar(
              backgroundColor: Color(Constant.color),
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    child: Image.asset(
                      "assets/images/log.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    _titles[index],
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      WebNavigationBar(
                        onItemSelected: (index) => _selectedIndex.value = index,
                        selectedIndex: _selectedIndex,
                      ),
                      const SizedBox(width: 10),
                      _buildLanguageToggle(),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
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
            SizedBox(height: 24,),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return
        InkWell(
          onTap: (){
            context.read<LanguageCubit>().toggleLanguage();

          },
          child: Image.asset(
            locale.languageCode == 'en'
                ? 'assets/images/ain.png'
                : 'assets/images/english.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          )
        );
      },
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

          Row(
            children: [
              _navItem(AppLocalizations.of(context)!.home, 0),
              _navItem(AppLocalizations.of(context)!.about, 1),
              InkWell(
                child: Icon(Icons.shopping_cart_outlined),
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
              color: isSelected ? Colors.brown : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
}
