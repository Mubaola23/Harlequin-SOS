import 'package:flutter/material.dart';

import '../../core/constants.dart';

class AppDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final Color textColor;

  const AppDropdown({
    Key key,
    @required this.items,
    @required this.value,
    @required this.onChanged,
    this.controller,
    this.validator,
    this.textColor = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kExtraSmallVerticalSpacing,
        DropdownButtonFormField(
          items: items.map(
            (String item) {
              return new DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(color: textColor, fontSize: 18),
                ),
              );
            },
          ).toList(),
          onChanged: onChanged,
          value: value,
          validator: validator,
          icon: Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
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
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
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
