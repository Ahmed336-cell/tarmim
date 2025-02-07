import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarmim/features/home/data/repo/home_repo.dart';
import 'package:tarmim/features/home/presentation/home_mobile.dart';
import 'package:tarmim/features/home/presentation/home_web.dart';
import 'package:tarmim/features/home/presentation/manager/home_state.dart';

import '../../../constants.dart';
import 'manager/home_cubit.dart';

class HomeRespo extends StatelessWidget {
  const HomeRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepo())..fetchProducts(),
      child: BlocListener<HomeCubit,HomeState>(
        listener: (context,state){

        },

        child: LayoutBuilder(
            builder: (context, constraints) {
              BlocProvider.of<HomeCubit>(context).fetchProducts();
              if (constraints.maxWidth > 600) {
                return Scaffold(

                  body:  WebHomePage(),
                );
              } else {
                return Scaffold(

                  body:  MobileHomePage(),
                );
              }
            },
        ),
      ),
    );
  }
}
