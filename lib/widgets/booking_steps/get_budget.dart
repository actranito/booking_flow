import 'package:booking_flow/constants/generic.dart';
import 'package:booking_flow/controllers/booking/booking_cubit.dart';
import 'package:booking_flow/models/booking_info.dart';
import 'package:booking_flow/widgets/custom_button.dart';
import 'package:booking_flow/widgets/select_one_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget is a BookingStep and is used to get the budget for a booking.
class GetBudgetBookingStep extends StatefulWidget {
  final BookingInfo bookingInfo;
  final void Function() onContinue;

  /// Constructor for this widget.
  /// Parameters:
  ///   bookingInfo -> The current bookingInfo object
  ///   onContinue -> The function to execute when the "Continue" button is
  ///                 pressed.
  const GetBudgetBookingStep({
    Key? key,
    required this.bookingInfo,
    required this.onContinue,
  }) : super(key: key);

  @override
  _GetBudgetBookingStepState createState() => _GetBudgetBookingStepState();
}

class _GetBudgetBookingStepState extends State<GetBudgetBookingStep> {
  // Variable used to keep track of the currently selected budget
  late int _selectedBudgetIndex;

  @override
  void initState() {
    super.initState();

    // Check if there is any budget value prevously selected, if so set the
    // selectedBudgetIndex to that value
    this._selectedBudgetIndex = kBookingBudgets.indexWhere((element) =>
        element.minValue == this.widget.bookingInfo.budget.minValue);

    // In case the currently selected budget is unknown, we select the first
    // option by default
    if (this._selectedBudgetIndex == 0) {
      this._selectedBudgetIndex = 0;
    }
  }

  void onSelected(int index) {
    this.setState(() {
      this._selectedBudgetIndex = index;
    });
    (context).read<BookingCubit>().updateBookingInfo(this
        .widget
        .bookingInfo
        .copyWith(budget: kBookingBudgets[this._selectedBudgetIndex]));
  }

  @override
  Widget build(BuildContext context) {
    // Create a List<String> containing only the displayableValues
    var displayableValues = kBookingBudgets
        .map((bookingBudget) => bookingBudget.displayableValue)
        .toList();

    // Display a SelectOne dialog to show the possible budget options
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 13,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SelectOneDialog(
                    options: displayableValues,
                    onSelected: this.onSelected,
                    selectedIndex: this._selectedBudgetIndex,
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    title: 'Continue',
                    onPressed: () {
                      this.widget.onContinue();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
