import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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
import 'features/main_navigation/manager/language_cubit.dart';


void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Web


    Bloc.observer = Observe();

    // Initialize Supabase
    await Supabase.initialize(
      url: Constant.url,
      anonKey: Constant.apiKay,
    );

    // Lock device orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Initialize Sentry for error tracking
    await SentryFlutter.init(
          (options) {
        options.dsn = Constant.sentryKey; // Replace with your actual DSN
        options.tracesSampleRate = 1.0; // Adjust sampling rate if needed
      },
      appRunner: () => runApp(MyApp()), // Run the app inside Sentry’s tracking zone
    );
  }, (error, stackTrace) {
    // Log unhandled errors to Sentry
    Sentry.captureException(error, stackTrace: stackTrace);
  });
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
