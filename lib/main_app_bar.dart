//main_app_bar
import 'package:flutter/material.dart';
import 'settings_page.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSettingsPressed;
  final List<Widget>? actions;

  const MainAppBar({
    Key? key,
    required this.title,
    this.onSettingsPressed,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: onSettingsPressed ?? () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("فتح الإعدادات")),
          );
        },
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      actions: actions ?? [const SizedBox(width: 48)], // علشان التوازن
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
