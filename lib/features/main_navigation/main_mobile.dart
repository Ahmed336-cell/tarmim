import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tarmim/features/aboutus/presentation/about_us.dart';
import '../../constants.dart';
import '../cart/presentation/cart_respo.dart';
import '../home/presentation/home_respo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'manager/language_cubit.dart';

class MainMobile extends StatefulWidget {
  const MainMobile({Key? key}) : super(key: key);

  @override
  State<MainMobile> createState() => _MainMobileState();
}

class _MainMobileState extends State<MainMobile> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final List<Widget> _pages =  [
    HomeRespo(),
    CartRespo(),
    AboutUsScreen(),
  ];


  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [AppLocalizations.of(context)!.home, AppLocalizations.of(context)!.cart, AppLocalizations.of(context)!.about];

    return Scaffold(
      backgroundColor: Colors.white,
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
              actions: [
                _buildLanguageToggle(),
              ],
            );
          },
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) {
          return IndexedStack(
            index: index,
            children: _pages,
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: ValueListenableBuilder<int>(
              valueListenable: _selectedIndex,
              builder: (context, index, _) {
                return GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 4,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 100),
                  tabBackgroundColor: Color(Constant.color),
                  color: Colors.black,
                  tabs:  [
                    GButton(
                      icon: LineIcons.home,
                      text: AppLocalizations.of(context)!.home,
                    ),
                    GButton(
                      icon: LineIcons.shoppingCart,
                      text: AppLocalizations.of(context)!.cart,
                    ),
                    GButton(
                      icon: LineIcons.infoCircle,
                      text: AppLocalizations.of(context)!.about,
                    ),
                  ],
                  selectedIndex: index,
                  onTabChange: (newIndex) {
                    _selectedIndex.value = newIndex;
                  },
                );
              },
            ),
          ),
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
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              )
          );
      },
    );
  }
}
