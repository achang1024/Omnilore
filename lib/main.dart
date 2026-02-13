import 'package:flutter/material.dart';
import 'package:omnilore_scheduler/window_sizing/window_sizing.dart';
import 'package:omnilore_scheduler/widgets/screen.dart';
import 'package:omnilore_scheduler/theme.dart';

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

const List<Color> clusterColors = [
  Colors.green,
  Colors.purple,
  Colors.yellow,
  Colors.brown,
  Colors.deepOrange,
  Colors.amber,
  Colors.pinkAccent,
  Colors.blue
];

// ignore: constant_identifier_names
int colorNum = 0;

void main() async {
  // Initialize widgets
  WidgetsFlutterBinding.ensureInitialized();
  await setAppMinWindowSize();

  // Start app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// This widget is the root of your application.
  /// this builds the widget tree
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omnilore Scheduler',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(
                Colors.blueGrey.shade600), // Set Button hover color
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.black),
            backgroundColor:
                WidgetStateProperty.all(themeColors['WhiteBlue']),
            overlayColor: WidgetStateProperty.all(
                Colors.blueGrey.shade600), // Set Button hover color
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Screen(),
    );
  }
}
