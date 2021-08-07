import 'package:booking_flow/models/booking_budget.dart';

/// This List is used to define the different budgets for the user to select from.
/// (Ideally this should not be harcoded and should be fetched from a config file,
/// for example).
final List<BookingBudget> kBookingBudgets = [
  BookingBudget(minValue: 1800, maxValue: 5000, currencyAbbr: 'kr'),
  BookingBudget(minValue: 5000, maxValue: 10000, currencyAbbr: 'kr'),
  BookingBudget(minValue: 10000, maxValue: 20000, currencyAbbr: 'kr'),
  BookingBudget(minValue: 20000, maxValue: 40000, currencyAbbr: 'kr'),
  BookingBudget(minValue: 40000, currencyAbbr: 'kr'),
];
