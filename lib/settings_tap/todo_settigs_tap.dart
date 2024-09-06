import 'package:flutter/material.dart';
import 'package:new_application/settings_tap/theme_selection.dart';

class SettingsTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200.0, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThemeSelection(),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
