import 'package:flutter/material.dart';
import 'package:tarmim/features/main_navigation/main_mobile.dart';
import 'package:tarmim/features/main_navigation/main_web.dart';

import '../../constants.dart';

class MainRespo extends StatelessWidget {
  const MainRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(

            body: const MainWeb(),
          );
        } else {
          return Scaffold(
            body: const MainMobile(),
          );
        }
      },
    );
  }
}

