import 'package:intl/intl.dart';

/// This class is used to create a Budget object
class BookingBudget {
  final int minValue;
  final int? maxValue;
  final String currencyAbbr;
  late String _displayableValue;

  /// Constructor for a BookingBudget object.
  /// Parameters:
  ///   minValue -> The minimum value of the budget interval.
  ///   maxValue -> The maximum value of the budget interval (Optional) - If the
  ///               max value is not included, we will assume its infinite.
  ///   currencyAbbr  ->  A String containing the abbreviation of the currency
  ///                     being used.
  BookingBudget({
    required this.minValue,
    this.maxValue,
    required this.currencyAbbr,
  }) {
    // Generate the formatter to format the amount accordingly
    NumberFormat formatter =
        NumberFormat.currency(locale: 'sv_SE', symbol: '', decimalDigits: 0);
    if (this.maxValue == null) {
      this._displayableValue =
          'Over ${formatter.format(this.minValue)} ${this.currencyAbbr}';
    } else {
      this._displayableValue =
          '${formatter.format(this.minValue)} - ${formatter.format(this.maxValue)} ${this.currencyAbbr}';
    }
  }

  String get displayableValue => this._displayableValue;
}
