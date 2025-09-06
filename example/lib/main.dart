import 'package:flutter/material.dart';
import 'package:happy_slider/happy_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Slider Examples')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: [
            // Example 1: Basic usage with default icon
            HappySlider(
              width: 300,
              height: 60,
              sliderWidth: 120,
              text: "Slide to confirm",
              buttonText: "Confirm",
              onSlideComplete: () {
                print("Slider completed!");
              },
            ),

            // Example 2: Custom icon
            HappySlider(
              width: 300,
              height: 60,
              sliderWidth: 140,
              text: "Slide to unlock",
              buttonText: "Unlock",
              buttonIcon: Icon(Icons.lock_open, color: Colors.white),
              buttonColor: Colors.green,
              borderColor: Colors.green,
              onSlideComplete: () {
                print("Unlocked!");
              },
            ),

            // Example 3: Custom SVG icon (if you have flutter_svg)
            HappySlider(
              width: 300,
              height: 60,
              sliderWidth: 100,
              text: "Slide to pay",
              buttonIcon: Icon(Icons.payment, color: Colors.white),
              buttonColor: Colors.blue,
              showDefaultIcon: false, // Don't show default icon
              onSlideComplete: () {
                print("Payment initiated!");
              },
            ),

            // Example 4: Completely custom slider button
            HappySlider(
              width: 300,
              height: 70,
              sliderWidth: 150,
              text: "Swipe to continue",
              sliderButton: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                  ),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.swipe_right, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Swipe",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onSlideComplete: () {
                print("Custom slider completed!");
              },
            ),

            // Example 5: No icon, text only
            HappySlider(
              width: 300,
              height: 50,
              sliderWidth: 80,
              text: "Slide me",
              buttonText: "GO",
              showDefaultIcon: false,
              buttonColor: Colors.orange,
              buttonTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onSlideComplete: () {
                print("Text only slider!");
              },
            ),

            // Example 6: Custom styling
            HappySlider(
              width: 320,
              height: 65,
              sliderWidth: 160,
              text: "Emergency Slide",
              buttonText: "EMERGENCY",
              buttonIcon: Icon(Icons.warning, color: Colors.white, size: 20),
              buttonColor: Colors.red,
              borderColor: Colors.red,
              backgroundColor: Colors.red.withOpacity(0.1),
              borderWidth: 3,
              borderRadius: 32,
              buttonTextStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textStyle: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              onSlideComplete: () {
                print("Emergency activated!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
