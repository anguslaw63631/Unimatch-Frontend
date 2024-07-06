import 'package:flutter/material.dart';

class stNormal extends StatelessWidget {
  final String imgPath;
  const stNormal({
    super.key,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Image.asset(imgPath, height: 40,),
    );
  }
}
