import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrievee/main.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required ThemeState themeState});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings page
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Change Language'),
            onTap: () {
              // Implement language change functionality
            },
          ),
          ListTile(
            leading: themeState.themeData.brightness == Brightness.dark
                ? const Icon(Icons.brightness_3_rounded) // Moon icon for dark mode
                : const Icon(Icons.brightness_5_outlined), // Sun icon for light mode
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeState.themeData.brightness == Brightness.dark,
              onChanged: (newValue) => themeState.toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }
}
