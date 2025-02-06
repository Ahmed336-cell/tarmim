import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/product.dart';


class HomeRepo {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Product>> fetchProducts() async {
    try {
      // Fetch products from the database
      final response = await _supabaseClient.from('products').select().order('id', ascending: true);

      if (response is List) {
        return response.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products: Response is not a list');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }

  }
}