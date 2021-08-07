import 'package:bloc/bloc.dart';
import 'package:booking_flow/constants/generic.dart';
import 'package:equatable/equatable.dart';
import 'package:booking_flow/models/booking_info.dart';

part 'booking_state.dart';

/// This BLoC class is used to handle the booking data input and the booking
/// submission.
class BookingCubit extends Cubit<BookingState> {
  BookingCubit()
      : super(CollectingBookingDataState(
            BookingInfo(budget: kBookingBudgets[0])));

  /// This method is used to update the booking info and re-emit the
  /// CollectingBookingDataState.
  /// Parameters:
  ///   bookingInfo:  The new bookingInfo object to be saved.
  void updateBookingInfo(BookingInfo bookingInfo) {
    emit(CollectingBookingDataState(bookingInfo));
  }
}
