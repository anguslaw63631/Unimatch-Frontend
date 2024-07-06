// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';

class TfOutlined extends StatelessWidget {
  final controller;
  final String? hint;
  final Color? hintColor;
  final bool? hideText;
  final Color? color;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const TfOutlined({
    super.key,
    required this.controller,
    this.hideText,
    this.hint,
    this.hintColor,
    this.color,
    this.prefixIcon,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: hintColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(width: 2, color: color ?? Colors.indigo.shade600),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}