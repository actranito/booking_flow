/// This model is used to create objects for each of different booking dialog
/// steps.
class BookingDialogStep {
  final String? title;
  final String? subtitle;
  final String? text;

  /// Constructor for the BookingDialogStep.
  /// Parameters:
  ///   title -> Title for the step (Optional).
  ///   subtitle -> Subtitle for the step (Optional).
  ///   text -> Aditional text to be displayed (Optional).
  BookingDialogStep({
    this.title,
    this.subtitle,
    this.text,
  });
}
