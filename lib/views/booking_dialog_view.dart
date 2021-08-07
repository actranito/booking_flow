import 'package:booking_flow/models/booking_dialog_step.dart';
import 'package:booking_flow/widgets/booking_dialog_appbar.dart';
import 'package:booking_flow/widgets/booking_steps/get_budget.dart';
import 'package:booking_flow/widgets/booking_steps/get_user_name.dart';
import 'package:booking_flow/widgets/custom_button.dart';
import 'package:flutter/material.dart';

/// This class returns a Booking Dialog Widget.
/// This Widget is responsible for collecting the user's booking info and
/// then setting up the booking on the server
class BookingDialogView extends StatefulWidget {
  BookingDialogView({Key? key}) : super(key: key);

  @override
  _BookingDialogViewState createState() => _BookingDialogViewState();
}

class _BookingDialogViewState extends State<BookingDialogView> {
  // This list is used to keep track of all the necessary steps for the
  // booking process. In case there is a need to add another step, just add
  // another BookingDialogStep object to the list in the index where you want
  // it to appear.
  // The progress indicator is automatically updated by using the length of this
  // list.
  final List<BookingDialogStep> _bookingDialogSteps = [
    BookingDialogStep(
      title: 'Name',
      subtitle: 'Book video call for quote',
      body: GetUserNameBookingStep(),
    ),
    BookingDialogStep(
      title: 'Budget',
      subtitle: 'Book video call for quote',
      body: GetBudgetBookingStep(),
    ),
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
            if (this._currentStepIndex < this._bookingDialogSteps.length) {
              return this.displayBookingSteps();
            } else {
              return this.displaySummary();
            }
          },
        ));
  }

  /// This mehtod is used to display all the booking steps that are in the
  /// "bookingDialogSteps" variable. The steps will be displayed by index order.
  Widget displayBookingSteps() {
    return Column(
      children: [
        BookingDialogAppBar(
          title: this._bookingDialogSteps[this._currentStepIndex].title,
          subtitle: this._bookingDialogSteps[this._currentStepIndex].subtitle,
          showBackButton: this._currentStepIndex > 0,
          bookingProgress: this.calculateBookingProgress(),
          onBackButtonPressed: this.decrementStepIndex,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _bookingDialogSteps[_currentStepIndex].body ?? Container(),
                CustomButton(
                  title: 'Continue',
                  onPressed: this.incrementStepIndex,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// This method is used to display a summary of the input data by the user.
  /// This will show at the end of all the booking steps and a back arrow will
  /// be displayed, allowing the user to go back to the booking steps if
  /// necessary.
  Widget displaySummary() {
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
