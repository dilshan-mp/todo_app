import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Textfields extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final bool isPassword;
  const Textfields(
      {super.key,
      required this.hintText,
      required this.textInputType,
      required this.isPassword});

  @override
  State<Textfields> createState() => _TextfieldsState();
}

class _TextfieldsState extends State<Textfields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: TextField(
        //controller: _controller, // Attach the controller to the TextField
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword,

        decoration: InputDecoration(
          hintText:
              widget.hintText, // Use the hintText property for placeholder text
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4), // Rounded corners for top-left
              bottomLeft: Radius.circular(4), // Square corners for bottom-left
              topRight: Radius.circular(4), // Square corners for top-right
              bottomRight:
                  Radius.circular(4), // Square corners for bottom-right
            ),
            borderSide:
                BorderSide(color: Colors.transparent), // No visible border
          ),
          filled: true, // Fill color
          fillColor:
              const Color(0xFF1D1D1D), // Background color of the TextField
          contentPadding:
              const EdgeInsets.fromLTRB(0, 12, 0, 0), // Custom padding
        ),
        style: const TextStyle(
          color: Colors.white, // Text color inside the TextField
        ),
      ),
    );
  }
}
