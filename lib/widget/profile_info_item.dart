import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final bool showEditIcon;
  final VoidCallback? onEditPressed;

  const ProfileInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.showEditIcon = false,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(label),
      subtitle: Text(value),
      trailing: showEditIcon
          ? IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditPressed,
            )
          : null,
    );
  }
}
