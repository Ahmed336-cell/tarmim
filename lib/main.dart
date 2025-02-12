import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarmim/bloc_observer.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart';
import 'features/cart/presentation/manager/cart_state.dart';
import 'features/main_navigation/manager/language_cubit.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= Observe();
  await Supabase.initialize(
    url: Constant.url,
    anonKey: Constant.apiKay,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((value)=>runApp(
 MyApp(), // Wrap your app
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>CartCubit(CartRepository())..loadCart(context)),
        BlocProvider(create: (context) => LanguageCubit()), // ✅ LanguageCubit remains the same
      ],
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale, // ✅ Now listens to LanguageCubit
              home: const MainRespo(),
            );
          },
        ),
      );
  }
}
