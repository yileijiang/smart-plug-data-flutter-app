import 'package:flutter/material.dart';
import 'package:smart_plug_data/ui/screens/registered_smart_plugs_page.dart';
import 'package:smart_plug_data/ui/screens/settings_page.dart';

class MenuAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MenuAppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    PopupMenuItem<int> buildPopupMenuItem({
      required int value,
      required IconData icon,
      required String title,
    }) {
      return PopupMenuItem<int>(
        value: value,
        child: ListTile(
            leading: Icon(icon),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )),
      );
    }

    return AppBar(
      title: Text(title),
      actions: [
        PopupMenuButton<int>(
          icon: const Icon(
            Icons.more_vert,
          ),
          onSelected: (value) {
            if (value == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            } else if (value == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisteredSmartPlugsPage()),
              );
            }
          },
          itemBuilder: (context) => [
            buildPopupMenuItem(
              value: 1,
              icon: Icons.settings,
              title: 'Settings',
            ),
            buildPopupMenuItem(
              value: 2,
              icon: Icons.power,
              title: 'Registered Smart Plugs',
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
