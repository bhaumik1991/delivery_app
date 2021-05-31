import 'package:delivery_app/components/custom_suffix_icon.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/components/form_error_text.dart';
import 'package:delivery_app/screens/otp/otp_screen.dart';
import 'package:delivery_app/utils/app_constant.dart';
import 'package:delivery_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CompleteProfileBody extends StatefulWidget {
  @override
  _CompleteProfileBodyState createState() => _CompleteProfileBodyState();
}

class _CompleteProfileBodyState extends State<CompleteProfileBody> {
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
                  "Complete Profile",
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
                CompleteProfileForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.07,),
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

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String phone_number;
  String address;
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
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30),),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30),),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30),),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20),),
          DefaultButton(
            text: 'Continue',
            press: (){
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                Navigator.pushNamed(context, OTPScreen.routeName);
              }
            },
          ),

        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => name = newValue,
        onChanged: (value){
          if(value.isNotEmpty){
            removeError(error: kNamelNullError);
          }
          return null;
        },
        validator: (value){
          if(value.isEmpty){
            addError(error: kNamelNullError);
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Name",
            hintText: "Enter your name",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/User.svg",
            )
        )
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phone_number = newValue,
        onChanged: (value){
          if(value.isNotEmpty){
            removeError(error: kPhoneNumberNullError);
          }
          return null;
        },
        validator: (value){
          if(value.isEmpty){
            addError(error: kPhoneNumberNullError);
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Phone Number",
            hintText: "Enter your phone number",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Phone.svg",
            )
        )
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => name = newValue,
        onChanged: (value){
          if(value.isNotEmpty){
            removeError(error: kAddressNullError);
          }
          return null;
        },
        validator: (value){
          if(value.isEmpty){
            addError(error: kAddressNullError);
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Address",
            hintText: "Enter your address",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Location point.svg",
            )
        )
    );
  }
}

