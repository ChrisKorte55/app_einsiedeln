// lib/views/install_instructions.dart
import 'package:flutter/material.dart';

class InstallInstructions extends StatelessWidget {
  const InstallInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Install Instructions"),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text("Step 1: Download the installer from the official site."),
            Text("Step 2: Run the installer and follow the on-screen instructions."),
            Text("Step 3: Launch the app once installation is complete."),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
