import 'package:flutter/material.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFFE5E5E5), // TODO - Check if this is the correct BG color
      body: Center(
        child: Text('Start Booking'),
      ),
    );
  }
}
