import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WebsiteFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Center(
        child: Text(
          '© 2025 Your Company. All rights reserved.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}