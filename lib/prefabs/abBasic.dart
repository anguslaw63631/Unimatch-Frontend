import 'package:flutter/material.dart';

import '../const.dart';

class AppbarBasic extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String? title;
  final Color? bgColor;
  final Color? color;
  final double? elevation;
  final IconData? icon;
  final Function() onTap;
  final bool? enableActions;
  final dynamic? actions;

  const AppbarBasic({
    super.key,
    required this.appBar,
    required this.onTap,
    this.title,
    this.color,
    this.bgColor,
    this.icon,
    this.elevation,
    this.enableActions,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: elevation ?? 0,
      title: Text(title ?? "", style: TextStyle(color: color ?? appBarTextColor, fontWeight: FontWeight.w500),),
      leading: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon ?? Icons.arrow_back,
          color: color ?? appBarTextColor,
        ),
      ),
      actions:
        (enableActions ?? false) ? actions ?? [const SizedBox.shrink()] : [const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
