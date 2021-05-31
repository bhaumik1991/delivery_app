import 'package:delivery_app/components/custom_suffix_icon.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/components/form_error_text.dart';
import 'package:delivery_app/utils/app_constant.dart';
import 'package:delivery_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class ForgotPasswordBody extends StatefulWidget {
  @override
  _ForgotPasswordBodyState createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
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
                SizedBox(height: SizeConfig.screenHeight * 0.04,),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Please enter your email and we will send \nyou a link to return to your account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),
                ForgotPasswordForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),
                SizedBox(height: getProportionateScreenHeight(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                          color: kPrimaryColor
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();
  String email;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20),),

          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: 'Continue',
            press: (){
              if(formKey.currentState.validate()){
                formKey.currentState.save();
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
          if(value.isNotEmpty && errors.contains(kEmailNullError)){
            setState(() {
              errors.remove(kEmailNullError);
            });
          }else if(emailValidatorRegExp.hasMatch(value) && errors.contains(kInvalidEmailError)){
            setState(() {
              errors.remove(kInvalidEmailError);
            });
          }
          return null;
        },
        validator: (value){
          if(value.isEmpty && !errors.contains(kEmailNullError)){
            setState(() {
              errors.add(kEmailNullError);
            });
          }else if(!emailValidatorRegExp.hasMatch(value) && !errors.contains(kInvalidEmailError)){
            setState(() {
              errors.add(kInvalidEmailError);
            });
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
}

