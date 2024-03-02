import 'package:flutter/material.dart';
import '../style/app_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  final IconData? actionsIcon;
  final IconData? leadingIcon;
  final Widget? title;
  final Widget? drawerBuilder;
  final Function()? onTapLeading;
  final Function()? onTapActions;
  const CustomAppBar(
      {super.key,
      this.title,
      this.drawerBuilder,
      this.actionsIcon,
      this.leadingIcon,
      this.onTapActions,
      this.onTapLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      toolbarHeight: 150,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: drawerBuilder ??
          IconButton(
            icon: Icon(leadingIcon,
                size: 25, color: Theme.of(context).iconTheme.color),
            onPressed: onTapLeading,
          ),
      actions: actionsIcon != null
          ? [
              Container(
                width: 40,
                margin: const EdgeInsets.fromLTRB(0, 30, 15, 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppStyle.secondaryColor.withOpacity(0.4)),
                child: IconButton(
                  icon: Icon(
                    actionsIcon,
                    color: Theme.of(context).iconTheme.color,
                    size: 25,
                  ),
                  onPressed: onTapActions,
                ),
              ),
            ]
          : null,
    );
  }
}
