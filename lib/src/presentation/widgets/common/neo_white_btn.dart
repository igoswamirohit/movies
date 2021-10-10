import 'package:flutter/material.dart';

class NeoWhiteBtn extends StatelessWidget {
  const NeoWhiteBtn({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Colors.red, elevation: 1),
      ),
    );
  }
}
