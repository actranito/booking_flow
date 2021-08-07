import 'package:booking_flow/constants/colors.dart';
import 'package:booking_flow/constants/text_styles.dart';
import 'package:flutter/material.dart';

/// This class returns an AppBar for the booking Dialog.
/// This should be diferent for any booking dialog step.
/// This AppBar shows a title (Optional), a subtitle (Optional), a backButton
/// (must be defined in the parameters if it should be shown) and will also
/// display a progress bar indicating the progress of the booking process.
/// Parameters:
///   title     -> The string to be displayed as the title (Optional).
///   subtitle  -> The String to be displayed as the subtitle (Optional).
///   showBackbutton  -> A boolean to control if the back button is displayed.
///   onBackButtonPressed ->  The function to be executed when the back button
///                           is pressed.
///   bookingProgress -> A double indicating the progress of the booking process.
class BookingDialogAppBar extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool showBackButton;
  final void Function() onBackButtonPressed;
  final double bookingProgress;

  const BookingDialogAppBar({
    Key? key,
    this.title,
    this.subtitle,
    required this.showBackButton,
    required this.onBackButtonPressed,
    required this.bookingProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // These const values are used to align the subtitle with the title
    // horizontally
    const double backButtonSize = 22.0;
    const double titleLeftPadding = 16.0;
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (this.showBackButton)
                    // Back Button
                    InkWell(
                      onTap: this.onBackButtonPressed,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: backButtonSize,
                      ),
                    ),
                  Expanded(
                    child: (this.title != null)
                        // Only show the title if not null
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: this.showBackButton
                                    ? titleLeftPadding
                                    : 0.0),
                            child: Text(
                              this.title!,
                              style: CustomTextStyles.BOOKING_DIALOG_TITLE,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Container(),
                  ),
                  // Cancel Button
                  InkWell(
                    onTap: () {
                      // If the cancel button is pressed, we want to close the
                      // ModalBottomSheet
                      NavigatorState navigator = Navigator.of(context);
                      if (navigator.canPop()) {
                        navigator.pop();
                      }
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              if (this.title != null && this.subtitle != null)
                // Only show a SizedBox separator if both title and subtitle
                // are not null
                SizedBox(height: 6.0),
              if (this.subtitle != null)
                // Only show the subtitle if not null
                Padding(
                  // Left padding is used to align the subtitle with the title
                  // horinzontally
                  padding: EdgeInsets.only(
                      left: this.showBackButton
                          ? backButtonSize + titleLeftPadding + 1.5
                          : 0.0),
                  child: Text(
                    this.subtitle!,
                    style: CustomTextStyles.BOOKING_DIALOG_SUBTITLE,
                  ),
                )
            ],
          ),
        ),
        // Progress Indicator
        Container(
          height: 4.0,
          width: screenSize.width * this.bookingProgress,
          color: CustomColors.PURPLE,
        ),
      ],
    );
  }
}
