import 'package:delivery_app/auth_screens/sign_in.dart';
import 'package:delivery_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:delivery_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:delivery_app/screens/otp/otp_screen.dart';
import 'package:delivery_app/screens/sign_up/sign_up_screen.dart';
import 'package:delivery_app/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OTPScreen.routeName: (context) => OTPScreen(),
};