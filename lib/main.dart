import 'package:flutter/material.dart';
import 'package:zone_app/src/core/injection_container.dart' as sl;
import 'package:zone_app/src/features/devices/presentation/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsScreen(),
    );
  }
}
