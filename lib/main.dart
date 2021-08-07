import 'package:booking_flow/views/startup_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // This is used to dismiss the soft keyboard when any non clickable part
      // of the screen is touched.
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartupView(),
      ),
    );
  }
}
