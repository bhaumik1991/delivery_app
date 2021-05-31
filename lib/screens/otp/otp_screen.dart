import 'package:delivery_app/screens/otp/components/body.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  static String routeName = '/otp';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
      ),
      body: OTPBody(),
    );
  }
}
