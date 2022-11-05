import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Example
      ///YourName: My Name Is On 28th Line
      appBar: greenAppBar(),
      body: whiteBody(),
      floatingActionButton: newMsgButton(),
    );
  }

  AppBar greenAppBar() {
    return AppBar(
      backgroundColor: Colors.green.shade900,
      title: Text('WhatsApp'),
    );
  }

  Widget whiteBody() {
    return Center(
      child: Text(
        'Loading chats...',
        style: TextStyle(
          color: Colors.red.shade800,
          fontSize: 28,
        ),
      ),
    );
  }

  Widget newMsgButton() {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.green,
      child: Icon(Icons.chat),
    );
  }


  void onPressed(){
    ///Nothing to do
  }


}
