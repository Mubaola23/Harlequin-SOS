import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransparentStatusbar extends StatelessWidget {
  final Widget child;

  const TransparentStatusbar({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: child,
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
