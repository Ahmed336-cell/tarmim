import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant{
  static const int color= 0xffede6dc;
  static String get apiKey => dotenv.env['apiKay'] ?? 'No API Key';
  static String get sentryKey => dotenv.env['sentryKey'] ?? 'No Sentry Key';
  static String get supabaseUrl => dotenv.env['url'] ?? 'No Supabase URL';
  static String get mailApiKey => dotenv.env['mailApiKey'] ?? 'No Mail API Key';
}