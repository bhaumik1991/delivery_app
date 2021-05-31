import 'package:delivery_app/auth_screens/sign_in.dart';
import 'package:delivery_app/utils/app_constant.dart';
import 'package:delivery_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "image": "assets/images/splash-1.png",
      "text": "Welcome to K-Mart, Let's Shop",
    },
    {
      "image": "assets/images/splash-2.png",
      "text": "We help people connect with store \naround India",
    },
    {
      "image": "assets/images/splash-3.png",
      "text": "We show the easy way to shop. \nJust stay at home with us",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value){
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]["text"],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index)
                      ),
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Spacer(flex: 3,),
                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(56),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        color: kPrimaryColor,
                          onPressed: (){
                            Navigator.pushNamed(context, SignInScreen.routeName);
                          },
                          child: Text(
                            "Let's Get Started",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white
                            ),
                          )
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key, this.text, this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            "K-Mart",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
            text,
            textAlign: TextAlign.center,
        ),
        Spacer(flex: 2,),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        )
      ],
    );
  }
}
