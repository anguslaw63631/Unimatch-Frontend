// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TfBasic extends StatelessWidget {
  final controller;
  final String? hint;
  final bool? hideText;
  final Color? hintColor;
  final Color? color;
  final Widget? suffixIcon;

  const TfBasic({
    super.key,
    required this.controller,
    this.hideText,
    this.hint,
    this.hintColor,
    this.color,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: color ?? Colors.indigo.shade600),
      controller: controller,
      obscureText: hideText ?? false,
      decoration: InputDecoration(
        hintText: hint ?? "",
        hintStyle: TextStyle(color: hintColor ?? Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: hintColor ?? Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: color ?? Colors.indigo.shade600),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}