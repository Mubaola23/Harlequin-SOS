import 'package:flutter/material.dart';

import '../../core/constants.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final Color textColor;
  final bool isLoading;
  final String label;
  final EdgeInsets padding;
  final Function func;

  const AppButton({
    Key key,
    @required this.onPressed,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.func,
    this.padding = const EdgeInsets.symmetric(
      vertical: 16,
    ),
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      textColor: textColor,
      padding: padding,
      child: isLoading
          ? SizedBox(
              width: 25.0,
              height: 25.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
