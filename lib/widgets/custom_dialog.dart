import 'package:booking_flow/constants/text_styles.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

/// This Widget displays a CustomDialog
class CustomDialog extends StatelessWidget {
  final String title;

  const CustomDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 153.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.title,
              style: CustomTextStyles.ALERT_DIALOG_TITLE,
            ),
            CustomButton(
              title: 'Dismiss',
              onPressed: () {
                NavigatorState navigator = Navigator.of(context);
                if (navigator.canPop()) {
                  navigator.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
