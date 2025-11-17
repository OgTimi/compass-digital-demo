import 'package:flutter/material.dart';
import 'screens/restaurant_list_screen.dart';

void main() {
  runApp(const CompassDigitalApp());
}

class CompassDigitalApp extends StatelessWidget {
  const CompassDigitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compass Digital Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RestaurantListScreen(),
    );
  }
}
