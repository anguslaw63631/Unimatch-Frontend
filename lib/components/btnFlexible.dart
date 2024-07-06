import 'package:flutter/material.dart';

class BtnFlexible extends StatelessWidget {
  final Function()? onTap;
  final String name;
  final double? ratio;
  final double? height;
  final double? fontSize;
  Color? startColor;
  Color? endColor;

  BtnFlexible({
    super.key,
    required this.name,
    this.onTap,
    this.startColor,
    this.endColor,
    this.ratio,
    this.height,
    this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    double width = ratio ?? 0.25;
    if (onTap == null) {
      startColor = Colors.grey.shade300;
      endColor = Colors.grey.shade300;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(colors: [
            startColor ?? Colors.indigo,
            endColor ?? Colors.indigoAccent],)
      ),
      child: TextButton(
        style: FilledButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.grey.shade300,
          fixedSize: Size(MediaQuery.of(context).size.width * width, height ?? 50),
        ),
        onPressed: onTap,
        child: Text(name, style: TextStyle(color: onTap == null ? Colors.grey.shade500 : Colors.white, fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),),
      )
    );
  }
}