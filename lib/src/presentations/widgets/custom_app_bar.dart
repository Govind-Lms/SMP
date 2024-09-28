import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool? centerTitle;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.actions, 
      this.centerTitle,});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toUpperCase(),style: Style.sixteenBold),
      backgroundColor: backgroundColor,
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
