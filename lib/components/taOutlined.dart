// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';

class TaOutlined extends StatelessWidget {
  final controller;
  final String? hint;
  final Color? hintColor;
  final bool? hideText;
  final Color? bgColor;
  final Color? color;

  const TaOutlined({
    super.key,
    required this.controller,
    this.hint,
    this.hintColor,
    this.hideText,
    this.bgColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 5,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      style: TextStyle(color: color ?? Colors.indigo.shade600),
      controller: controller,
      obscureText: hideText ?? false,
      decoration: InputDecoration(
        hintText: hint ?? "",
        hintStyle: TextStyle(overflow: TextOverflow.visible, color: hintColor ?? Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(width: 1, color: hintColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(width: 3, color: color ?? Colors.indigo.shade600,),
        ),
      ),
    );
  }
}