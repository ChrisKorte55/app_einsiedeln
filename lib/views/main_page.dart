import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MainPage extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  const MainPage({
    Key? key,
    required this.onLocaleChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.welcomeTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                appLoc.drawerHeader,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(appLoc.drawerItem1),
              onTap: () {
                // Handle tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLoc.welcomeMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onLocaleChange(const Locale('de')),
              child: const Text('Deutsch'),
            ),
            ElevatedButton(
              onPressed: () => onLocaleChange(const Locale('en')),
              child: const Text('English'),
            ),
          ],
        ),
      ),
    );
  }
}
