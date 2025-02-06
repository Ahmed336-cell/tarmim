import 'dart:convert';

class CartItem {
  final int id;
  final String name;
  final String image;
  final double basePrice;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.basePrice,
    required this.quantity,
  });

  double get totalPrice => basePrice * quantity;
  // CopyWith method to create a new instance with modified values
  CartItem copyWith({
    int? id,
    String? name,
    String? image,
    double? basePrice,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      basePrice: basePrice ?? this.basePrice,
      quantity: quantity ?? this.quantity,
    );
  }
}


class Order {
  final List<CartItem> items;
  final String name;        // <-- add name here
  final String country;
  final String state;
  final String city;
  final String address;
  final String phoneNumber;
  final double totalPrice;
  final String email;
  final String promoCode;
  Order({
    required this.items,
    required this.name,      // <-- add name here
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.phoneNumber,
    required this.totalPrice,
    required this.email,
    required this.promoCode,
  });

  /// Map data to match your "orders" table columns
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phoneNumber,
      'country': country,
      'state': state,
      'city': city,
      'address': address,
      // Store items + email as JSON in "orderDetails"
      'orderDetails': jsonEncode({
        'items': items.map((item) => {
          'id': item.id,
          'name': item.name,
          'quantity': item.quantity,
          'price': item.basePrice,
        }).toList(),
      }),
      'price': totalPrice,
      'isDelivered': false,               // default
      'date': DateTime.now().toString(), // or toIso8601String()
    };
  }
}

