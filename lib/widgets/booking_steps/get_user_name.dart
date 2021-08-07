import 'package:booking_flow/constants/colors.dart';
import 'package:booking_flow/constants/text_styles.dart';
import 'package:booking_flow/models/booking_info.dart';
import 'package:flutter/material.dart';

/// This widget is a BookingStep and is used to get the name of the user.
class GetUserNameBookingStep extends StatelessWidget {
  final BookingInfo bookingInfo;

  /// Constructor for this widget.
  /// Parameters:
  ///   bookingInfo -> The current bookingInfo object
  const GetUserNameBookingStep({
    Key? key,
    required this.bookingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      child: TextField(
        textCapitalization: TextCapitalization.words,
        cursorColor: CustomColors.GRAY_2,
        cursorHeight: 20.0,
        cursorWidth: 1.0,
        style: CustomTextStyles.TEXT_FIELD_EDITABLE_TEXT,
        decoration: InputDecoration(
          labelText: 'Your full name',
          labelStyle: CustomTextStyles.TEXT_FIELD_LABEL,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: CustomColors.TEXT_FIELD_OUTLINE,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: CustomColors.TEXT_FIELD_OUTLINE,
            ),
          ),
        ),
      ),
    );
  }
}
