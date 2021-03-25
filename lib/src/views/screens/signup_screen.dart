import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:harlequinsos/src/views/screens/login_screen.dart';
import 'package:harlequinsos/src/views/widgets/app_button.dart';
import 'package:harlequinsos/src/views/widgets/app_dropdown.dart';
import 'package:harlequinsos/src/views/widgets/app_textfield.dart';

import 'file:///C:/Users/user/Documents/Flutter/harlequin_sos/lib/src/core/constants.dart';
import 'file:///C:/Users/user/Documents/Flutter/harlequin_sos/lib/src/core/images.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Center(
            child: Text(
          "Registration",
          style: kHeadingTextStyle,
        )),
      ),
      body: Column(
        children: [
          kSmallVerticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                user,
                width: 65.0,
              ),
            ],
          ),
          kSmallVerticalSpacing,
          form(context),
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
              children: [
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "First Name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "Last Name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "Username",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "Phone Number",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                Row(children: [
                  Expanded(
                    child: AppTextField(
                      hintText: "Age",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                    ),
                  ),
                  kSmallHorizontalSpacing,
                  Expanded(
                    child: AppDropdown(
                      items: [
                        'Sex',
                        'Male',
                        'Female',
                      ],
//                      text: 'Day of the week',
                      onChanged: (val) => text = val,
                      value: 'Sex',
                      validator: (val) => val == 'Select Sex'
                          ? 'Please select a valid Sex'
                          : null,
                    ),
                  ),
                ]),
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  hintText: "Confirm Password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
//            controller: controller.firstNameController,
//            validator: controller.validateNotEmpty,
                ),
                kLargeVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                          label: 'Sign Up',
//                  color: kPrimaryColor,
//                  isLoading: false,
                          textColor: Colors.white,
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()))),
                    ),
                  ],
                ),
                kSmallVerticalSpacing,
                haveAnAccount(),
                kLargeVerticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget haveAnAccount() {
    return Text.rich(
      TextSpan(
        text: 'Already have an account?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        children: <TextSpan>[
          TextSpan(
              text: ' Sign In',
              style: TextStyle(color: kPrimaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
                }),
        ],
      ),
    );
  }
}
