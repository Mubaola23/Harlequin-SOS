import 'package:flutter/material.dart';

import '../../core/constants.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final bool filled;
  final bool showCounterText;
  final bool obscureText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) validator;
  final bool enabled;
  final Function(String) onFieldSubmitted;
  final Function(String) onSaved;
  final TextInputAction textInputAction;
  final int maxlength;
  final InputBorder border;
  final InputBorder enabledBorder;
  final String title;
  final String label;
  final int maxLines;
  final Widget suffixIcon;
  final void Function(String) onChanged;
  final Color borderColor;
  final Color textColor;
  final double height;

  const AppTextField({
    Key key,
    this.label,
    this.hintText,
    this.text,
    this.controller,
    this.suffixIcon,
    this.enabled,
    this.onChanged,
    this.maxLines,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.borderColor,
    this.textColor = Colors.black87,
    this.filled,
    this.showCounterText,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.maxlength,
    this.border,
    this.enabledBorder,
    this.title,
    this.height,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kExtraSmallVerticalSpacing,
        TextFormField(
          onSaved: onSaved,
          controller: controller,
          style: TextStyle(color: textColor, fontSize: 18, height: height),
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          validator: validator,
          keyboardType: keyboardType,
          enabled: enabled,
          textInputAction: textInputAction ?? TextInputAction.next,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.all(16.0),
            border: InputBorder.none,
            filled: false,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor ?? Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? kPrimaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
