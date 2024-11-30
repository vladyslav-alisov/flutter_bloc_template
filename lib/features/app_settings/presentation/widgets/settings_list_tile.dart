import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData leadingIcon;
  final String title;
  final Widget? trailing;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 18,
          ),
      title: Text(title),
      leading: Icon(leadingIcon),
    );
  }
}
