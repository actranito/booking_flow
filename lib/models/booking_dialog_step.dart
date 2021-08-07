import 'package:flutter/material.dart';

/// This model is used to create objects for each of different booking dialog
/// steps.
class BookingDialogStep {
  final String? title;
  final String? subtitle;
  final Widget? body;

  /// Constructor for the BookingDialogStep.
  /// Parameters:
  ///   title -> Title for the step (Optional).
  ///   subtitle -> Subtitle for the step (Optional).
  ///   body  -> A widget to be displayed as the body of the step (Optional).
  BookingDialogStep({
    this.title,
    this.subtitle,
    this.body,
  });
}
