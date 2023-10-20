import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0x38509bff)),
          useMaterial3: true,
          fontFamily: 'FuturaBT Medium Condensed'),
      home: LandingPage(),
    );
  }
}

// Start page
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using Scaffold to make easier use of widgets
    return Scaffold(
      // Using Stack instead of Column to have background image
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/landing.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome message
                // Adding padding to separate text and button
                const Padding(
                  // Adding padding only to bottom
                  padding: EdgeInsets.only(bottom: 85.0),
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ),
                // Start button
                // Adding SizedBox widget to change button width
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      print('clic!');
                    },
                    child: const Text(
                      'Start',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
