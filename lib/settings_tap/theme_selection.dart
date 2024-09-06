
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Text(
          "Mode",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        InkWell(
          onTap: () {
            showThemeBottomSheet(context);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xff5D9CEC),
                  width: 1),
              // borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Text(
              themeProvider.getCurrentThemeText(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ThemeBottomSheet();
        });
  }
}

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      color: Colors.white,
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  themeProvider.changeTheme(ThemeMode.light);
                });
              },
              child: themeProvider.isDark()
                  ? getUnSelectedItem(
                context,
                "light",
             )
                  : getSelectedItem(
                context,
               "light"
              )),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                setState(() {
                  themeProvider.changeTheme(ThemeMode.dark);
                });
              },
              child: themeProvider.isDark()
                  ? getSelectedItem(
                context,
               " dark"
              )
                  : getUnSelectedItem(
                context,
               "dark"
              )),
        ],
      ),
    );
  }
}

Widget getSelectedItem(BuildContext context, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.secondary),
      ),
      Icon(Icons.check, color: Theme.of(context).colorScheme.secondary)
    ],
  );
}

Widget getUnSelectedItem(BuildContext context, String text) {
  return Row(
    children: [
      Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    ],
  );
}
