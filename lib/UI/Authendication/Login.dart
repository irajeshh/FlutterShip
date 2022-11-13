import 'package:flutter/material.dart';
import 'package:fluttership/Widgets/Widgets.dart';

////Dummy page as of now
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(text: 'Login Page',),
    );
  }

  Widget body() {
    return Center(child: Txt(text: 'Login With Email'));
  }
}
