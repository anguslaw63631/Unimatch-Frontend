import 'package:flutter/material.dart';

class TutBasic extends StatelessWidget {
  final String title;
  final bool? showPrefixIcon;
  final bool? showSuffixIcon;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? status;

  const TutBasic({
    super.key,
    required this.title,
    this.showPrefixIcon,
    this.showSuffixIcon,
    this.prefixIcon,
    this.suffixIcon,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Colors.indigo, width: 5),
          shape: BoxShape.rectangle
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (showPrefixIcon ?? true) ? Icon(prefixIcon, color: Colors.indigo,) :  const SizedBox.shrink(),
              Text(
                title,
                style: TextStyle(color: Colors.indigo.shade600, fontSize: 20),
              ),
              (showSuffixIcon ?? false) ? Icon(suffixIcon, color: Colors.indigo,) : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
