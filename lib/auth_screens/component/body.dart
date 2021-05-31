import 'package:delivery_app/components/custom_suffix_icon.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/components/form_error_text.dart';
import 'package:delivery_app/components/social_card.dart';
import 'package:delivery_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:delivery_app/screens/sign_up/sign_up_screen.dart';
import 'package:delivery_app/utils/app_constant.dart';
import 'package:delivery_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInBody extends StatefulWidget {
  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
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
                      "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                      "Sign in with your email and password \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08,),
                  SigninForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Don't have an account?",
                        style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(
                              context,
                            SignUpScreen.routeName,
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                            color: kPrimaryColor
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20),),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20),),

          Row(
            children: [
              Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value){
                    setState(() {
                      remember = value;
                    });
                  }
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: (){
                  Navigator.popAndPushNamed(context, ForgotPasswordScreen.routeName);
                },
                child: Text(
                    "Forgot password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20),),
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => password = newValue,
        onChanged: (value){
          if(value.isNotEmpty && errors.contains(kPassNullError)){
            setState(() {
              errors.add(kPassNullError);
            });
          }else if(value.length >= 6 && errors.contains(kShortPassError)){
            setState(() {
              errors.add(kShortPassError);
            });
          }
          return null;
        },
        validator: (value){
          if(value.isEmpty && !errors.contains(kPassNullError)){
            setState(() {
              errors.add(kPassNullError);
            });
          }else if(value.length < 6 && !errors.contains(kShortPassError)){
            setState(() {
              errors.add(kShortPassError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your Password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Lock.svg",
            )
        )
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





