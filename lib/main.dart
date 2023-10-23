import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//imports
import './src/landing_page/landing_page.dart';
import './src/main_page/patient_list/patient_list.dart';

// colors
const appBarBackgroundColor = Color(0xFFEBEBEB);
const subtitleColor = Color(0x8b8b8bff);
const mainTextColor = Colors.black;
const darkContrastColor = Colors.white;
const mainColor = Color(0x38509bff);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PatientList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        // Changing the theme color seed to blue and font
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0x38509bff)),
            useMaterial3: true,
            fontFamily: 'FuturaBT Medium Condensed'),
        // Stablishing LandingPage as Home
        home: const LandingPage(),
      ),
    );
  }
}
