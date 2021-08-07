import 'package:flutter/material.dart';

/// This widget is a BookingStep and is used to get the name of the user.
class GetUserNameBookingStep extends StatelessWidget {
  final String? userName;

  /// Constructor for this widget.
  /// Parameters:
  ///   userName -> The name to be displayed on the textBox
  const GetUserNameBookingStep({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text((this.userName != null) ? this.userName! : ''),
    );
  }
}
