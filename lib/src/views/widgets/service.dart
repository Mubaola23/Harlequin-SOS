import 'package:flutter/material.dart';

import 'file:///C:/Users/user/Documents/Flutter/harlequin_sos/lib/src/core/constants.dart';

class Service extends StatelessWidget {
  final String img;
  final String label;

  const Service({
    Key key,
    @required this.img,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          img,
          width: MediaQuery.of(context).size.width / 4,
        ),
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: kBodyText1TextStyle,
        )
      ],
    );
  }
}
