import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarmim/features/cart/data/repo/cart_repo.dart';
import 'package:tarmim/features/cart/presentation/cart_respo.dart';
import 'package:tarmim/features/cart/presentation/manager/cart_cubit.dart';
import 'package:tarmim/features/delivery_details/presentaion/delivery_respo.dart';
import 'package:tarmim/features/details/presentation/details_respo.dart';
import 'package:tarmim/features/home/presentation/home_respo.dart';
import 'package:tarmim/features/home/presentation/home_web.dart';
import 'package:tarmim/features/main_navigation/main_respo.dart';
import 'package:tarmim/features/main_navigation/main_web.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Constant.url,
    anonKey: Constant.apiKay,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>CartCubit(CartRepository())..loadCart(),
        )
      ],
      child: const MaterialApp(
        home: MainRespo(),
      ),
    );
  }
}
