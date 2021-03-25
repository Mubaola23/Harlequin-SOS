import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:harlequinsos/src/views/screens/dashboard_screen.dart';
import 'package:harlequinsos/src/views/screens/signup_screen.dart';
import 'package:harlequinsos/src/views/widgets/app_button.dart';
import 'package:harlequinsos/src/views/widgets/app_textfield.dart';

import 'file:///C:/Users/user/Documents/Flutter/harlequin_sos/lib/src/core/constants.dart';
import 'file:///C:/Users/user/Documents/Flutter/harlequin_sos/lib/src/core/images.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo1,
                width: 200.0,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          form(context),
          Text(
            "Halequin Dev 2020",
            style: kLabelText,
          ),
        ],
      ),
    );
  }

  Widget form(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Halequin SOS",
                  style: kHeadingTextStyle,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "Type username here",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "Type password here",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kLargeVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                          label: 'Sign In',
//                  color: kPrimaryColor,
//                  isLoading: false,
                          textColor: Colors.white,
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DashboardScreen()))),
                    ),
                  ],
                ),
                kSmallVerticalSpacing,
                dontHaveAnAccount(),
                kLargeVerticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dontHaveAnAccount() {
    return Text.rich(
      TextSpan(
        text: 'Don\'t have an account?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        children: <TextSpan>[
          TextSpan(
              text: ' Sign Up',
              style: TextStyle(color: kPrimaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SignUpScreen()));
                }),
        ],
      ),
    );
  }
}
