import 'package:flutter/material.dart';
import 'package:tarmim/features/home/presentation/home_mobile.dart';
import 'package:tarmim/features/home/presentation/home_web.dart';

import '../../../constants.dart';

class HomeRespo extends StatelessWidget {
  const HomeRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Scaffold(

              body: const WebHomePage(),
            );
          } else {
            return Scaffold(

              body: const MobileHomePage(),
            );
          }
        },
    );
  }
}
