import 'package:booking_flow/constants/colors.dart';
import 'package:flutter/material.dart';

/// This class returns a TextButton Widget.
/// Parameters:
///   - title -> The String to display on the button (Optional)
///   - onPressed -> The function to execute when the button is pressed (Optional)
class CustomButton extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;

  const CustomButton({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      width: double.infinity,
      child: TextButton(
        onPressed: this.onPressed,
        child: Text(this.title ?? ''),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(CustomColors.WHITE),
            // If the onPressed function is null, set background color to
            // disabled color, else set to black
            backgroundColor: MaterialStateProperty.all(this.onPressed != null
                ? CustomColors.BUTTON_BG
                : CustomColors.BUTTON_DISABLED),
            overlayColor:
                MaterialStateProperty.all(CustomColors.BUTTON_OVERLAY),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            )),
      ),
    );
  }
}
