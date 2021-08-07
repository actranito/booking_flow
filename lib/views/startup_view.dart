import 'package:booking_flow/constants/colors.dart';
import 'package:booking_flow/views/booking_dialog_view.dart';
import 'package:booking_flow/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.SCAFFOLD_BG,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: CustomButton(
            title: 'Start Booking',
            onPressed: () {
              this.startBooking(context);
            },
          ),
        ),
      ),
    );
  }

  /// This method is used to start the booking process.
  /// It will open a modalBottomSheet to collect the booking info and process it
  void startBooking(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: CustomColors.SCAFFOLD_BG,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        isScrollControlled: true,
        builder: (context) {
          return BookingDialogView();
        }).then((value) => print(value));
  }
}
