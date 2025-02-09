import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarmim/generated/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.brown,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon('assets/icons/facebook.svg'),
              _socialIcon('assets/icons/instagram.svg'),
              _socialIcon('assets/icons/twitter.svg'),
              _socialIcon('assets/icons/google.svg'),
              _socialIcon('assets/icons/youtube.svg'),
            ],
          ),
          const SizedBox(height: 10),

          // Navigation Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _navItem(AppLocalizations.of(context)!.home),
              _navItem(AppLocalizations.of(context)!.about),
              _navItem(AppLocalizations.of(context)!.contact),

            ],
          ),
          const SizedBox(height: 10),

          // Copyright Text
          const Text(
            "Copyright ©2025",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SvgPicture.asset(
        assetPath,
        width: 30,
        height: 30,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
