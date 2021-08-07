import 'package:booking_flow/constants/colors.dart';
import 'package:flutter/material.dart';

/// This widget is a SelectOne dialog. It displays several options and the user
/// must choose one. By default the first option is selected.
class SelectOneDialog extends StatelessWidget {
  final List<String> options;
  final Function onSelected;
  final int? selectedIndex;

  const SelectOneDialog({
    Key? key,
    required this.options,
    required this.onSelected,
    this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: this.options.length,
      itemBuilder: (_, index) {
        return displaySelectOneButton(
          index,
          this.options[index],
          this.selectedIndex == index,
        );
      },
    );
  }

  /// This method displays a selectOne button.
  /// Parameters:
  ///   index -> The index regarding the current selectOne Button
  ///   text -> the text to be displayed in the button.
  ///   isSelected -> boolean value to indicate if the button is selected or not.
  Widget displaySelectOneButton(int index, String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      height: 44.0,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          this.onSelected(index);
        },
        child: Text(text),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(CustomColors.BLACK),
            overlayColor: MaterialStateProperty.all(
                CustomColors.SELECT_ONE_BUTTON_OUTLINE_OVERLAY),
            side: MaterialStateProperty.all(
              BorderSide(
                  width: isSelected ? 2.0 : 1.0,
                  color: isSelected
                      ? CustomColors.SELECT_ONE_BUTTON_OUTLINE_SELECTED
                      : CustomColors.SELECT_ONE_BUTTON_OUTLINE),
            ),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            )),
      ),
    );
  }
}
