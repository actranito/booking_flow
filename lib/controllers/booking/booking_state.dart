part of 'booking_cubit.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

/// This state is emitted when the app is collecting the booking information
/// from the user.
class CollectingBookingDataState extends BookingState {
  final BookingInfo bookingInfo;

  CollectingBookingDataState(this.bookingInfo);

  @override
  List<Object> get props => [this.bookingInfo];
}

/// This state is emitted when the app is trying to submit the booking.
class SubmittingBookingState extends BookingState {}

/// This state is emitted when the booking was submitted successfully.
class BookingCompletedState extends BookingState {}

/// This state is emitted when an error occured.
class BookingErrorState extends BookingState {}
