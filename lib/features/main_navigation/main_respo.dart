import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarmim/core/commons/custom_button.dart';
import 'package:tarmim/features/main_navigation/main_mobile.dart';
import 'package:tarmim/features/main_navigation/main_web.dart';

import 'manager/main_cubit.dart';

class MainRespo extends StatelessWidget {
  const MainRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConnectivityCubit(),
      child: BlocBuilder<ConnectivityCubit, bool>(
        builder: (context, isConnected) {
          if (!isConnected) {
            return _buildNoInternetScreen(context);
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 600 ? const MainWeb() : const MainMobile();
            },
          );
        },
      ),
    );
  }

  Widget _buildNoInternetScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Image.asset("assets/images/internet.jpg", height: 200),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: () => context.read<ConnectivityCubit>().checkConnection(), // ✅ Fixed this
                text: "Retry",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
