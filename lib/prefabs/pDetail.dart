import 'package:flutter/material.dart';

class PDetail extends StatelessWidget {
  final String title;
  final bool? showPrefixIcon;
  final bool? showSuffixIcon;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? status;

  const PDetail({
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
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                (showPrefixIcon ?? true) ? Icon(
                  prefixIcon ?? Icons.question_mark,
                  color: Colors.indigo.shade800,
                ) : const SizedBox.shrink(),
                const SizedBox(width: 5,),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.indigo.shade800,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      maxLines: 3,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      status ?? "Empty",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.indigo.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
