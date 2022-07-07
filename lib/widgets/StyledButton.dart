import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final text;

  StyledButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: buttonText(text),
        ),
      ),
    );
  }
}
