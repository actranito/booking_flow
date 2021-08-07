import 'package:booking_flow/models/booking_budget.dart';

/// This class is used to create an object that will keep track of and validate
/// the booking info entered by the user.
class BookingInfo {
  final String? userName;
  final BookingBudget budget;

  /// Constructor for a BookingInfo object
  BookingInfo({
    this.userName,
    required this.budget,
  });

  /// This method is used to validate if the current info of the object is valid
  /// to be submitted.
  bool isBookingInfoValidToSubmit() {
    bool isValid = true;

    // userName validation
    if (this.userName == null) {
      // (Simple name validation, some extra validations could be considered here)
      isValid = false;
    }

    return isValid;
  }

  /// This method is used to create a copy from the current BookingInfo
  BookingInfo copyWith({
    String? userName,
    BookingBudget? budget,
  }) {
    return BookingInfo(
      userName: userName ?? this.userName,
      budget: budget ?? this.budget,
    );
  }
}
