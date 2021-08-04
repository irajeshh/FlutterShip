import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';
import 'package:flutter/services.dart';

class ButtonExample extends StatefulWidget {
  const ButtonExample({ Key key }) : super(key: key);

  @override
  _ButtonExampleState createState() => _ButtonExampleState();
}

class _ButtonExampleState extends State<ButtonExample> {

  bool uploading = false;

  @override
  void initState() { 
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(),
      body: body(),
      backgroundColor: Colorz.buttonExampleCanvas,
    );
  }


  AppBar appBar(){
    return AppBar(
      title: Txt(text: "Button Example"),
      backgroundColor: Colorz.complexDrawerBlack,
    );
  }


  Widget body(){
    return  Center(
          child: Button(
            width: 180,
            text: "Upload File",
            processingText: "Uploading...",
            ontaskCompletedText: "Upload Again", //(["Upload Next","Upload Next File","Done"]..shuffle())[0],
            icon: Icons.cloud_upload,
            buttonColor: Colorz.buttonSampleColor,
            processing: uploading,
            onPressed: ()async{
              setState(()=>uploading=true);
              await Future.delayed(Duration(seconds:3));
              setState(()=>uploading=false);
            },
          ),
        );
  }
}