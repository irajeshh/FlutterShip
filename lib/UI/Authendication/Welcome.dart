import 'package:flutter/material.dart';
import 'package:fluttership/UI/Authendication/Login.dart';
import 'package:fluttership/Widgets/Widgets.dart';

///A page where we just welcoming the new or existing users
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ///Photo taken form website

  @override
  Widget build(BuildContext context) {
    return Material(
      child: myContainer(),
    );
  }

  Widget myContainer() {
    String ladyPhotoUrl =
        'https://images.unsplash.com/photo-1552196563-55cd4e45efb3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1026&q=80';
    return Container(
      height: Widgets.mheight(context),
      width: Widgets.mwidth(context),
      decoration: BoxDecoration(
          color: Colors.green,
          image: DecorationImage(
            image: NetworkImage(ladyPhotoUrl),
            fit: BoxFit.fitHeight,
          )),

      /// child: ladyPhoto(), Old method
      child: largeColumn(),
    );
  }

  // Widget ladyPhoto() {
  //  String photoUrl ='https://images.unsplash.com/photo-1552196563-55cd4e45efb3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1026&q=80';
  //   return Image.network(
  //     photoUrl,
  //     height: Widgets.mheight(context),
  //     width: Widgets.mwidth(context),
  //     fit: BoxFit.fitHeight,
  //   );
  //  }

  Widget largeColumn() {
    return Column(
      children: [
        topPadding(),
        appNameWidget(),
        Spacer(),
        startButton(),
        txtRow(),
        bottomPadding(),
      ],
    );
  }

  Widget topPadding() {
    return Padding(
      padding: EdgeInsets.only(top: 62.5),
    );
  }

  Widget appNameWidget() {
    return Txt(
      text: 'Deep Slate',
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  Widget startButton() {
    return Container(
      height: 75,
      child: Button(
        text: 'Get Started',
        textColor: Colors.black,
        buttonColor: Colors.white,
        width: 275,
        radius: 90,
        onPressed: openLoginPageFn,
      ),
    );
  }

  Widget txtRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          alreadyTxt(),
          loginTxt(),
        ],
      ),
    );
  }

  Widget alreadyTxt() {
    return Txt(
      text: 'Already have account?',
      color: Colors.white,
    );
  }

  Widget loginTxt() {
    return GestureDetector(
      onTap: openLoginPageFn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Txt(
          text: 'Log in',
          color: Colors.white,
          underline: true,
        ),
      ),
    );
  }

  Widget bottomPadding() {
    return Padding(
        padding: EdgeInsets.only(
      bottom: 62.5,
    ));
  }

  void openLoginPageFn() {
    Widgets.push(LoginPage(), context);
  }
}
