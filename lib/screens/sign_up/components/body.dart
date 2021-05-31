import 'package:delivery_app/components/custom_suffix_icon.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/components/form_error_text.dart';
import 'package:delivery_app/components/social_card.dart';
import 'package:delivery_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:delivery_app/utils/app_constant.dart';
import 'package:delivery_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class SignupBoby extends StatefulWidget {
  @override
  _SignupBobyState createState() => _SignupBobyState();
}

class _SignupBobyState extends State<SignupBoby> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03,),
                Text(
                  "Register Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Complete your details \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.07,),
                SignupForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.07,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: (){},
                    ),
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: (){},
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: (){},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20),),
                Text(
                    "By continuing you're confirm that you agree \nwith our Term and Conditions",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String confirm_password;
  final List<String> errors = [];

  void addError({String error}){
    if(!errors.contains(error)){
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}){
    if(!errors.contains(error)){
      setState(() {
        errors.remove(error);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30),),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30),),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30),),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20),),
          DefaultButton(
            text: 'Continue',
            press: (){
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),

        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value){
          if(value.isNotEmpty){
            removeError(error: kEmailNullError);
          }else if(emailValidatorRegExp.hasMatch(value)){
            removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value){
          if(value.isEmpty){
            addError(error: kEmailNullError);
          }else if(!emailValidatorRegExp.hasMatch(value)){
            addError(error: kInvalidEmailError);
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your Email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Mail.svg",
            )
        )
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }


  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirm_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirm_password) {
          removeError(error: kMatchPassError);
        }
        confirm_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}

