import 'package:flutter/material.dart';
import 'package:zone_app/src/core/injection_container.dart' as sl;
import 'package:zone_app/src/features/devices/presentation/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  runApp(const MyApp());
}

class ZoneTheme {
  static const mainColor = Color(0x00FF00);
  static const secondaryColor = Color(0x00B500);
  static const fontColor = Color(0x4E4E4E);
  static const backgroundColor = Color(0x0A0A09);
  static const buttoncolor = Color(0x181818);
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
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(24, 24, 24, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        //Fonts
        fontFamily: 'Roboto',

        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                color: Color.fromRGBO(0, 181, 0, 1),
              ),
              bodyLarge: const TextStyle(color: Color.fromRGBO(0, 181, 0, 1)),
            ),
        // textTheme: ThemeData(),
      ),
      home: SettingsScreen(),
    );
  }
}
