import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tarmim/constants.dart';
import 'package:tarmim/features/cart/data/model/cart_item.dart';

class EmailService {
  final String apiKey = dotenv.env['mailApiKey']!;

  Future<void> sendOrderConfirmation({
    required String toEmail,
    required String toName,
    required String address,
    required String city,
    required String gov,
    required List<CartItem> orderDetails,
    required String totalPrice,
  }) async {
    const String apiUrl = 'https://api.brevo.com/v3/smtp/email';
    String formattedOrderDetails = orderDetails.map((item) {
    return '- ${item.name} (Qty: ${item.quantity}, Price: ${item.basePrice})';
    }).join('<br>');
    final Map<String, dynamic> emailData = {
      'sender': {'name': 'Tarmim-Seller', 'email': 'tarmimtarmim516@gmail.com'},
      'to': [
        {'email': toEmail, 'name': toName}
      ],
      'subject': 'Order Confirmation',
      'htmlContent': '''
  <img src="https://thzvmfihypywknllqqnx.supabase.co/storage/v1/object/public/products//logo.png" alt="Tarmim Logo" width="150" />
  <h1>Thank you for your order!</h1>
  <h2>Dear $toName,</h2>
  <p>Your order has been placed successfully. Here are your order details:</p>
  <pre>$formattedOrderDetails</pre>
  <p><strong>Shipping Address:</strong> $address, $city, $gov</p>
  <h3>total price : $totalPrice</h3>
  <h3>Best regards,<br>Your Store Team</h3>
''',

    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'api-key': apiKey,
      },
      body: jsonEncode(emailData),
    );

    if (response.statusCode == 201) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email: ${response.body}');
    }
  }
}
