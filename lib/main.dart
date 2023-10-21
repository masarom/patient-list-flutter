import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x38509bff)),
          useMaterial3: true,
          fontFamily: 'FuturaBT Medium Condensed'),
      home: const LandingPage(),
    );
  }
}

// Start page
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()));
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

// Main page
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Adding updated date to appbar
    final currentDate = DateTime.now();
    /*  Simplified format:
        final formattedDate =
        '${currentDate.day}/${currentDate.month}/${currentDate.year}'; */
    final formattedDate = DateFormat.yMMMMd().format(currentDate);
    // colors
    final appBarTextColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      // adding widgets to edit the AppBar styles (shadow, borders)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: AppBar(
            // adding a row to include different elements
            title: Row(
              // Making automatic space between elements
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hi, Welcome', style: TextStyle(color: appBarTextColor)),
                Text(formattedDate),
              ],
            ),
            backgroundColor: const Color(0xFFEBEBEB),
            // Delete the "go back" default arrow
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      // Content
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main title
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Patient List',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 58.0),
                child: Text('There are no patients in the list yet',
                    style: TextStyle(fontSize: 20, color: Color(0x8b8b8bff)))),
            // Search bar
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Full name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: const EdgeInsets.all(13.0),
                          hintStyle: const TextStyle(
                              fontSize: 19.0, color: Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: appBarTextColor, shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        // Lógica de búsqueda aquí
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // add new patient icon
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton(
          backgroundColor: appBarTextColor,
          onPressed: () {
            print('new patient!');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
