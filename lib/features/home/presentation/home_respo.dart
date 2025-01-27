import 'package:flutter/material.dart';
import 'package:tarmim/features/home/presentation/home_mobile.dart';
import 'package:tarmim/features/home/presentation/home_web.dart';

class HomeRespo extends StatelessWidget {
  const HomeRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Scaffold(
              appBar: AppBar(

                backgroundColor: Colors.blue.shade900,
                centerTitle: true,
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              body: const WebHomePage(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(

                backgroundColor: Colors.blue.shade900,
                centerTitle: true,
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              body: const MobileHomePage(),
            );
          }
        },
    );
  }
}
