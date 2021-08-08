import 'package:booking_flow/constants/enums.dart';
import 'package:booking_flow/controllers/booking/booking_cubit.dart';
import 'package:booking_flow/models/booking_dialog_step.dart';
import 'package:booking_flow/models/booking_info.dart';
import 'package:booking_flow/widgets/booking_dialog_appbar.dart';
import 'package:booking_flow/widgets/booking_steps/get_budget.dart';
import 'package:booking_flow/widgets/booking_steps/get_user_name.dart';
import 'package:booking_flow/widgets/custom_button.dart';
import 'package:booking_flow/widgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This class returns a Booking Dialog Widget.
/// This Widget is responsible for collecting the user's booking info and
/// then setting up the booking on the server
class BookingDialogView extends StatefulWidget {
  BookingDialogView({Key? key}) : super(key: key);

  @override
  _BookingDialogViewState createState() => _BookingDialogViewState();
}

class _BookingDialogViewState extends State<BookingDialogView> {
  /// This list is used to keep track of all the necessary steps for the
  /// booking process. In case there is a need to add another step, just add
  /// another BookingDialogStep object to the list in the index where you want
  /// it to appear.
  /// The progress indicator is automatically updated by using the length of this
  /// list.
  /// !IMPORTANT! - Please make sure to update the "getStepView" method when
  /// changing this list. If not, an exception will be thrown to warn you about it.
  final List<BookingDialogStep> _bookingDialogSteps = [
    BookingDialogStep(
      title: 'Name',
      subtitle: 'Book video call for quote',
      text:
          'Thank you for booking a video call with Done.\nFirst we need to know a bit about you.',
    ),
    BookingDialogStep(
        title: 'Budget',
        subtitle: 'Book video call for quote',
        text:
            'What is your budget? We will be in touch if we believe your project won\'t fit into the budget.'),
  ];

  // This variable is used to select which booking step to be displayed
  int _currentStepIndex = 0;

  /// Method used to increment the currentStepIndex variable.
  void incrementStepIndex() {
    if (this._currentStepIndex < this._bookingDialogSteps.length) {
      this.setState(() {
        this._currentStepIndex++;
      });
    }
  }

  /// Method used to decrement the currentStepIndex variable.
  void decrementStepIndex() {
    if (this._currentStepIndex > 0) {
      this.setState(() {
        this._currentStepIndex--;
      });
    }
  }

  /// Method used to calculate the current progress of the booking process.
  ///
  /// returns -> A double between 0.0 and 1.0 corresponding to the percentage
  ///            of the booking process.
  double calculateBookingProgress() {
    return (this._currentStepIndex + 1) / (this._bookingDialogSteps.length + 1);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        height: screenSize.height * 0.93,
        child: BlocListener<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingCompletedState) {
              // If we change to the BookingCompletedState we want to close
              // the modalBottomSheet
              NavigatorState navigator = Navigator.of(context);
              if (navigator.canPop()) {
                navigator.pop(BookingResult.Confirmed);
              }
            }
            // If the state changes to errorState we show a dialog
            // and return to CollectingBookingDataState
            else if (state is BookingErrorState) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      CustomDialog(title: 'Something went wrong')).then(
                // When the error dialog is dismissed, we use the updateBookingInfo
                // method to go back to CollectingBookingDataState
                (value) => (context)
                    .read<BookingCubit>()
                    .updateBookingInfo(state.bookingInfo),
              );
            }
          },
          child: Builder(
            builder: (context) {
              // Watch for changes in the state of the BookingCubit and react
              // accordingly.
              BookingState bookingState = (context).watch<BookingCubit>().state;

              // If bookingState is CollectingBookingDataState we want to display
              // the different booking steps and, at the end, the summary
              if (bookingState is CollectingBookingDataState) {
                if (this._currentStepIndex < this._bookingDialogSteps.length) {
                  return this.displayBookingSteps(bookingState.bookingInfo);
                } else {
                  return this.displaySummary(bookingState.bookingInfo, false);
                }
              }
              // If the bookingState is SubmittingBookingState we want to display
              // the summary page and the "Confirming..." info on the button
              else if (bookingState is SubmittingBookingState) {
                return this.displaySummary(bookingState.bookingInfo, true);
              }
              // If the bookingState is BookingCompletedState we return an empty
              // container, because the BlocListener will close the
              // modalBottomSheet so nothing needs to be displayed
              else if (bookingState is BookingCompletedState) {
                return Container();
              }
              // If the bookingState is BookingErrorState we display
              // a dialog (done in the listener), and continue displaying the
              // bookingSteps/Summary
              else if (bookingState is BookingErrorState) {
                if (this._currentStepIndex < this._bookingDialogSteps.length) {
                  return this.displayBookingSteps(bookingState.bookingInfo);
                } else {
                  return this.displaySummary(bookingState.bookingInfo, false);
                }
              }
              // In case of Unknown State
              else {
                return Center(
                  child: Text('Unknown State'),
                );
              }
            },
          ),
        ));
  }

  /// This method is used to get the widget to display in the body of the
  /// Booking Dialog.
  /// Parameters:
  ///   bookingInfo -> The current booking info object.
  Widget getStepView(BookingInfo bookingInfo) {
    switch (this._currentStepIndex) {
      // In case the step index is 0 we want to display the widget to get the
      // user name
      case 0:
        return GetUserNameBookingStep(
          bookingInfo: bookingInfo,
          onContinue: this.incrementStepIndex,
        );

      // In case the step index is 1 we want to display the widget to get the
      // budget
      case 1:
        return GetBudgetBookingStep(
          bookingInfo: bookingInfo,
          onContinue: this.incrementStepIndex,
        );

      // Throw an error in case the step counter
      // has an unexpected value
      default:
        throw 'Unknown \"currentStepIndex\" value';
    }
  }

  /// This mehtod is used to display all the booking steps that are in the
  /// "bookingDialogSteps" variable. The steps will be displayed by index order.
  /// Parameters:
  ///   bookingInfo -> The current booking info object.
  Widget displayBookingSteps(BookingInfo bookingInfo) {
    // Using the viewInsets.bottom property to get the height of the keyboard,
    // so later we can adjust the modalBottomSheet content with it
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Column(
      children: [
        BookingDialogAppBar(
          title: this._bookingDialogSteps[this._currentStepIndex].title,
          subtitle: this._bookingDialogSteps[this._currentStepIndex].subtitle,
          text: this._bookingDialogSteps[this._currentStepIndex].text,
          showBackButton: this._currentStepIndex > 0,
          bookingProgress: this.calculateBookingProgress(),
          onBackButtonPressed: this.decrementStepIndex,
        ),
        Expanded(
          child: this.getStepView(bookingInfo),
        ),
        // This empty Container is used to push the content up when the keyboard is
        // opened so it won't be in front of any UI elements
        Container(
          color: Colors.transparent,
          height: keyboardHeight,
        ),
      ],
    );
  }

  /// This method is used to display a summary of the input data by the user.
  /// This will show at the end of all the booking steps and a back arrow will
  /// be displayed, allowing the user to go back to the booking steps if
  /// necessary.
  /// Parameters:
  ///   bookingInfo -> The current booking info object.
  ///   isSubmitting -> Flag that indicates if the booking is being submitted
  Widget displaySummary(BookingInfo bookingInfo, bool isSubmitting) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BookingDialogAppBar(
          title: 'Summary',
          subtitle: 'Book video call for quote',
          showBackButton: this._currentStepIndex > 0,
          onBackButtonPressed: isSubmitting ? null : this.decrementStepIndex,
          bookingProgress: this.calculateBookingProgress(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 34.0,
            ),
            child: Column(
              children: [
                bookingInfo.displayBookingInfoSummary(),
                Expanded(
                  child: Container(),
                ),
                CustomButton(
                    leading: isSubmitting
                        ? Theme(
                            data: ThemeData(
                                cupertinoOverrideTheme: CupertinoThemeData(
                                    brightness: Brightness.dark)),
                            child: CupertinoActivityIndicator())
                        : null,
                    title: isSubmitting ? 'Confirming...' : 'Confirm booking',
                    onPressed: () {
                      // In case we are already submitting the booking we dont
                      // want to do it again in case the user presses the button
                      // again
                      if (!isSubmitting) {
                        (context)
                            .read<BookingCubit>()
                            .submitBooking(bookingInfo);
                      }
                    }),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
