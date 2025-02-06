import 'package:flutter/material.dart';
class OrderInfoRowMobile extends StatelessWidget {
  final String label;
  final String value;

  const OrderInfoRowMobile({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label , style: const TextStyle(color: Colors.black ,fontSize: 18 , fontWeight: FontWeight.bold)),
          Text(
            value,
            style: TextStyle(fontWeight:   FontWeight.bold , fontSize: 16),
          ),
        ],
      ),
    );
  }
}