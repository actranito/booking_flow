import 'package:booking_flow/constants/colors.dart';
import 'package:booking_flow/constants/text_styles.dart';
import 'package:booking_flow/controllers/booking/booking_cubit.dart';
import 'package:booking_flow/models/booking_info.dart';
import 'package:booking_flow/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget is a BookingStep and is used to get the name of the user.
class GetUserNameBookingStep extends StatefulWidget {
  final BookingInfo bookingInfo;
  final void Function() onContinue;

  /// Constructor for this widget.
  /// Parameters:
  ///   bookingInfo -> The current bookingInfo object.
  ///   onContinue -> The function to execute when the "Continue" button is
  ///                 pressed.
  const GetUserNameBookingStep({
    Key? key,
    required this.bookingInfo,
    required this.onContinue,
  }) : super(key: key);

  @override
  _GetUserNameBookingStepState createState() => _GetUserNameBookingStepState();
}

class _GetUserNameBookingStepState extends State<GetUserNameBookingStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    this._textEditingController =
        new TextEditingController(text: this.widget.bookingInfo.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: this._formKey,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: this._textEditingController,
                      onSaved: (textFieldValue) =>
                          (context).read<BookingCubit>().updateBookingInfo(
                                widget.bookingInfo
                                    .copyWith(userName: textFieldValue),
                              ),
                      textCapitalization: TextCapitalization.words,
                      cursorColor: CustomColors.GRAY_2,
                      cursorHeight: 20.0,
                      cursorWidth: 1.0,
                      style: CustomTextStyles.TEXT_FIELD_EDITABLE_TEXT,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Your full name',
                        labelStyle: CustomTextStyles.TEXT_FIELD_LABEL,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: CustomColors.TEXT_FIELD_OUTLINE,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: CustomColors.TEXT_FIELD_OUTLINE,
                          ),
                        ),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Name can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomButton(
                      title: 'Continue',
                      onPressed: () {
                        if (this._formKey.currentState != null) {
                          if (this._formKey.currentState!.validate()) {
                            this._formKey.currentState!.save();
                            this.widget.onContinue();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
