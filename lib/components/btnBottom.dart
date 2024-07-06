// ignore: camel_case_types
import 'package:flutter/material.dart';

class BtnBottom extends StatelessWidget {
  final Function()? onTap;
  final String name;
  final Color? startColor;
  final Color? endColor;

  const BtnBottom({
    super.key,
    required this.name,
    this.onTap,
    this.startColor,
    this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      gradient: LinearGradient(colors: [startColor ?? Colors.indigo, endColor ?? Colors.indigoAccent],)
                  ),
                  child: TextButton(
                    style: FilledButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 45),
                    ),
                    onPressed: onTap,
                    child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
              ],
            )
        )
    );
  }
}