import 'package:flutter/foundation.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                if (kDebugMode) {
                  print("Slider completed!");
                }
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
                if (kDebugMode) {
                  print("Unlocked!");
                }
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
                if (kDebugMode) {
                  print("Payment initiated!");
                }
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
                if (kDebugMode) {
                  print("Custom slider completed!");
                }
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
                if (kDebugMode) {
                  print("Text only slider!");
                }
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
              backgroundColor: Colors.red.withAlpha(25),
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
                if (kDebugMode) {
                  print("Emergency activated!");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
