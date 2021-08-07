import 'package:booking_flow/controllers/booking/booking_cubit.dart';
import 'package:booking_flow/models/booking_dialog_step.dart';
import 'package:booking_flow/models/booking_info.dart';
import 'package:booking_flow/widgets/booking_dialog_appbar.dart';
import 'package:booking_flow/widgets/booking_steps/get_budget.dart';
import 'package:booking_flow/widgets/booking_steps/get_user_name.dart';
import 'package:booking_flow/widgets/custom_button.dart';
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
                return this.displaySummary(bookingState.bookingInfo);
              }
            }
            // If the bookingState is SubmittingBookingState... TODO - finish
            else if (bookingState is SubmittingBookingState) {
              return Center(
                child: Text('SubmittingBookingState'),
              );
            }
            // If the bookingState is BookingCompletedState... TODO - finish
            else if (bookingState is BookingCompletedState) {
              return Center(
                child: Text('BookingCompletedState'),
              );
            }
            // If the bookingState is BookingErrorState... TODO - finish
            else if (bookingState is BookingErrorState) {
              return Center(
                child: Text('BookingErrorState'),
              );
            }
            // In case of Unknown State
            else {
              return Center(
                child: Text('Unknown State'),
              );
            }
          },
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
        return GetUserNameBookingStep(bookingInfo: bookingInfo);

      // In case the step index is 1 we want to display the widget to get the
      // budget
      case 1:
        return GetBudgetBookingStep(bookingInfo: bookingInfo);

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
    // TODO - Check if there is a better way to estimate the keyboard height
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              // This Column has two Expanded empty Containers with different
              // flex values of 1 and 3, respectively at the start and at the
              // bottom. This was done in order to have 1/4 of the available
              // space above the content and the remaining 3/4 below.
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                this.getStepView(bookingInfo),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomButton(
                    title: 'Continue',
                    onPressed: this.incrementStepIndex,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
              ],
            ),
          ),
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
  Widget displaySummary(BookingInfo bookingInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BookingDialogAppBar(
          title: 'Summary',
          subtitle: 'Book video call for quote',
          showBackButton: this._currentStepIndex > 0,
          onBackButtonPressed: this.decrementStepIndex,
          bookingProgress: this.calculateBookingProgress(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Summary'),
                CustomButton(
                  title: 'Confirm booking',
                  onPressed: () => print('Submit Booking'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
