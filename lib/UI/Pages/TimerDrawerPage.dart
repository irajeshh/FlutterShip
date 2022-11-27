import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class TimerDrawerPage extends StatefulWidget {
  const TimerDrawerPage({Key? key}) : super(key: key);

  @override
  _TimerDrawerPageState createState() => _TimerDrawerPageState();
}

class _TimerDrawerPageState extends State<TimerDrawerPage> {
  @override
  Widget build(BuildContext context) {
//optionally I use container with 1/3 of the media query width
    return Scaffold(
      appBar: appBar(),
      body: body(),
      drawer: drawer(),
    );
  }

/*
  I usually spilt the widgets into as many small chunks as possible
  to re-use them in other widets and this will help me 
  better when finding a specific error on a widget

  In the beginnging of my flutter life
  I created my first project into one single page :(

    It's a suggestion to split keep the widgets into small chunks
    and at the end its your wish...

  
*/

  AppBar appBar() {
    return AppBar(
      title: Txt(text: "Simple Drawer"),
    );
  }

  Widget body() {
    return Center(
      child: FlutterLogo(
        size: 150,
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: Column(
        children: [
          userAccountsDrawerHeader(),
          tilesBuilder(),
        ],
      ),
    );
  }

  Widget userAccountsDrawerHeader() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: width/2,
      width: width,
      color: Colorz.backgroundBlue,
      padding: EdgeInsets.only(top: 35, bottom: 8, left: 12, right: 12),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //this is why i split the widgets int chunks
            //anytime you can modify without recreating them
            avatar(),
            accountName(),
            accountEmail(),
            timerWidget(),
          ]),
    );
    // return UserAccountsDrawerHeader(
    //   currentAccountPicture: avatar(),
    //   accountName: accountName(),
    //   accountEmail: accountEmail(),
    // );
  }

  Widget avatar() {
    // I use pixabay.com & unsplash.com for non copyrighted images
    return Container(
      child: CircleAvatar(
        backgroundImage: NetworkImage(Urls.avatar3),
        //I don't use any default image widgets in my projects
        //Will share my Img() widget that I use on a regular basis,
      ),
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget accountName() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        //i don't use Text Widget, I use Txt - my custom widget
        //Will share the code in upcoming videos
        "Wallace Henderson",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget accountEmail() {
    // return Text("Owlerton Electric LLC");//this is enough if single line, but here we need to use his email, so let us go for RichText()
    // In general I don't use RichText ever,
    //I Use RichTxt() & RichString(), My custom widgets
    //will share them on upcoming videos
    ///as we use our custom header, we can use ListTile instead of
    ///richtext
    return ListTile(
      contentPadding: EdgeInsets.only(left: 8),
      title: Text("Owlerton Electric LLC",
          style: TextStyle(
            color: Colors.white,
          )),
      subtitle: Text("wallace.henderson@yahoo.com",
          style: TextStyle(
            color: Colors.white70,
          )),
    );
    // return RichText(
    //   text: TextSpan(
    //     children: [
    //       TextSpan(
    //         text: "Owlerton Electric LLC",

    //       ),
    //       TextSpan(
    //         text: "\nwallace.henderson@yahoo.com",
    //         style: TextStyle(
    //           color: Colors.white70,
    //         )
    //       ),
    //       // WidgetSpan(child: timerWidget()),// we dont have enough space
    //       //on default account header, let us build our own
    //     ]
    //   ),
    // );
  }

  Widget timerWidget() {
    return Card(
      color: Colorz.timerBlue,
      // child: ListTile(//this timer widget alignnment is not
      // //satifying, so let us build custom tile
      //   // contentPadding: EdgeInsets.only(left:3),
      //   leading: leadingButton(),
      //   title: clockStartedAt(),
      //   subtitle: runningTime(),
      // ),
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            leadingButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    clockStartedAt(),
                    runningTime(),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Widget leadingButton() {
    return Container(
      child: Icon(
        Icons.pause,
        color: Colors.white,
        size: 35,
      ),
      height: 65,
      width: 65,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colorz.backgroundBlue,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget clockStartedAt() {
    return Text(
      "CLOCK STARTED AT 09:01 AM",
      style: TextStyle(
        fontSize: 12,
        color: Colors.white60,
      ),
    ); //perfection :)
  }

  Widget runningTime() {
    return Text(
      "01:24:17",
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 40,
        color: Colors.white,
      ),
    ); // you can use the real timer widgets, but its just a clone not a working app, :)
  }

  //Now we are going to enter a problem on the default
  //userdrawer header
  //let see

  //The easy part

  Widget tilesBuilder() {
    return Flexible(
        child: ListView(children: [
      tile(title: "My profile", icon: Icons.account_circle),
      tile(title: "Account settings", icon: Icons.settings),
      tile(title: "Timesheet", icon: Icons.event, highLight: true),
      tile(title: "Logout", icon: Icons.logout),
      //to find the icons better i use https://fonts.google.com/icons?selected=Material+Icons+Outlined
    ]));
  }

//we are goign to reuse it again and again
  Widget tile({required String title, required IconData icon, bool highLight = false}) {
    Color txtColor = highLight ? Colorz.timerBlue : Colors.grey.shade700;
    Color iconColor = highLight ? Colorz.timerBlue : Colors.grey;
    return Container(
      child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: TextStyle(color: txtColor))),
      decoration: BoxDecoration(
        color: highLight ? Colors.blue.shade50 : null,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
