// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class btnNormal extends StatelessWidget {
  final Function()? onTap;
  final String name;
  final Color? bgColor;
  final Color? color;
  final double? margin;

  const btnNormal({
    super.key,
    required this.name,
    required this.onTap,
    this.color,
    this.bgColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.indigoAccent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: color ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}