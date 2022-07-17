import 'package:flutter/material.dart';
import 'package:zone_app/services/service_locator.dart';
import 'package:zone_app/ui/views/settings_screen.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Zone App',
      //Create the assets of the app
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // scaffoldBackgroundColor: Colors.black,

      ),
      home: SettingsPage(),
    );
  }
}
