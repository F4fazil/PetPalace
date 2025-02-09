import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType; // Add this attribute

  const MyTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text, // Default to text input
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText ? _isObscured : false,
        keyboardType: widget.keyboardType, // Use the provided keyboard type
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          iconColor: Colors.indigo.shade100,
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility : Icons.visibility_off,
              color: Colors.teal.shade300,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0Xff66cdaa), width: 0.4),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0Xff66cdaa), width: 0.6),
          ),
          fillColor: Colors.white.withOpacity(0.7),
          filled: true,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
