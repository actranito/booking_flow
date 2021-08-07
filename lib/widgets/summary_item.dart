import 'package:booking_flow/constants/text_styles.dart';
import 'package:flutter/material.dart';

/// This widget displays an item of the Booking Summary.
class SummaryItem extends StatelessWidget {
  final String title;
  final String? value;

  /// Constructor for this class.
  /// Parameters:
  ///   title -> The title of this summary item
  ///   value -> The value of this summary item (Optional). If null, an empty
  ///            String will de displayed.
  const SummaryItem({
    Key? key,
    required this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.title,
          style: CustomTextStyles.SUMMARY_TITLE,
        ),
        const SizedBox(height: 4.0),
        Text(
          this.value ?? '',
          style: CustomTextStyles.SUMMARY_VALUE,
        ),
      ],
    );
  }
}
