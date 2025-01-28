import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(onPressed: onPressed,
      color: Colors.brown,
      minWidth: double.infinity,
      height: 60,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20),),

    );
  }
}
