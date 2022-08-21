import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/IconLabel.dart';
import 'package:fluttership/Models/InterlacedEvent.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class InterLacedDashBoard extends StatefulWidget {
  const InterLacedDashBoard({Key? key}) : super(key: key);

  @override
  _InterLacedDashBoardState createState() => _InterLacedDashBoardState();
}

class _InterLacedDashBoardState extends State<InterLacedDashBoard> {
  IconLabel? selectedIconLabel; //helps to indetify which horizontal //grid is selected
  String selectedYwmd = '';
  List<int> selectedEventContainers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(),
      body: body(),
      backgroundColor: Colorz.interlacedBackground,
    );
  }

  // Widget appBar(){
  //   return AppBar(
  //     elevation: 0,
  //     backgroundColor: Colorz.interlacedBackground,
  //   );
  // }

  Widget body() {
    return ListView(
        shrinkWrap: true, //we use grid inside this list so...
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
        children: [
          leadingButton(),
          avatar(size: 150),
          userTile(),
          horizontalGrid(),
          avatarTinyYwmdChatRow(),
          bottomRow(),
        ]);
  }

  Widget leadingButton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }

  Widget avatar({double? size}) {
    return Container(
      // radius: radius??50,
      height: size ?? 50,
      width: size ?? 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        border: Border.all(
          width: 3,
          color: Colorz.interlacedAvatarBorderBlue,
        ),
        image: DecorationImage(
          image: NetworkImage(Urls.avatar4),
          fit:
              BoxFit.contain, //in realtime you will use an image cropper for 1:1 so use BoxFit.fill
        ),
      ),
    );
  }

  Widget userTile() {
    return ListTile(
      title: Txt(
        text: "Hello Rosalie",
        color: Colors.blueGrey,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(
        text: "rosalie.rice@gmail.com",
        textAlign: TextAlign.center,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget horizontalGrid() {
    // as the object has an icon and a lable, let us use a class

    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: iconLabels.length,
        itemBuilder: (context, int index) {
          BorderRadius? _borderRadius;
          Radius corner = Radius.circular(12); //you can set as 20
          switch (index) {
            case 0:
              _borderRadius = BorderRadius.only(topLeft: corner);
              break;
            case 3:
              _borderRadius = BorderRadius.only(topRight: corner);
              break;

            case 4:
              _borderRadius = BorderRadius.only(bottomLeft: corner);
              break;
            case 7:
              _borderRadius = BorderRadius.only(bottomRight: corner);
              break;
            // default: _borderRadius = null;
          }

          return horizontalGridChild(iconLabels[index], borderRadius: _borderRadius);
        });
  }

  Widget horizontalGridChild(IconLabel iconLabel, {BorderRadius? borderRadius}) {
    bool selected = selectedIconLabel == iconLabel;
    double fullWidth = MediaQuery.of(context).size.width;
    double width = fullWidth / 4; //half length of icons list

    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.white : null,
        border: Border.all(
          width: 0.25,
          color: selected ? Colors.white : Colors.grey.shade400,
        ),
        borderRadius: selected ? BorderRadius.circular(12) : borderRadius,
        boxShadow: [
          if (selected)
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.25,
              blurRadius: 0.25,
            ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIconLabel = iconLabel;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Icon(Icons.brightness_1,
                  size: 8, color: selected ? Colors.red : Colors.transparent),
              height: 15,
              width: width - 35,
            ),
            Icon(iconLabel.icon, color: selected ? Colors.blue.shade700 : Colors.grey),
            Txt(
              text: iconLabel.label,
              color: selected ? Colors.blueGrey : Colors.grey,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }

  Widget avatarTinyYwmdChatRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        avatar(size: 30),
        ywmdRow(),
        chatChip(),
      ],
    );
  }

  Widget ywmdRow() {
    return Row(
      children: ywmdList.map((ywmd) {
        BorderRadius? br;
        int index = ywmdList.indexOf(ywmd);
        Radius corner = Radius.circular(360);
        switch (index) {
          case 0:
            br = BorderRadius.only(topLeft: corner, bottomLeft: corner);
            break;

          case 3:
            br = BorderRadius.only(topRight: corner, bottomRight: corner);
            break;

          default:
        }
        return ywmdChip(ywmd, borderRadius: br);
      }).toList(),
    );
  }

  Widget ywmdChip(String ywmd, {BorderRadius? borderRadius}) {
    bool selected = selectedYwmd == ywmd;

    return InkWell(
      onTap: () {
        setState(() {
          selectedYwmd = ywmd;
        });
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Txt(
          text: ywmd,
          fontSize: 11,
          color: selected ? Colors.purple : Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade300,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  Widget chatChip() {
    return Chip(
      avatar: Icon(Icons.forum, color: Colors.white),
      label: Txt(text: "Start Chat", color: Colors.white),
      backgroundColor: Colorz.interlacedChatPurple,
    );
  }

  Widget bottomRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalChips(),
          staggaredColorGrid(),
        ],
      ),
    );
  }

  Widget verticalChips() {
    List<IconLabel> verticalIconLabels = [
      IconLabel(Icons.search, "Search..."),
      IconLabel(Icons.location_on, "New York"),
      IconLabel(Icons.face, "Adrain Nader"),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: verticalIconLabels.map((il) {
        //  IconLabel il = verticalIconLabels[index];
        return Chip(
          avatar: Icon(il.icon, color: Colors.grey, size: 18),
          label: Txt(
            text: il.label,
            fontSize: 10,
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
      }).toList(),
    );
  }

  //ref: https://www.youtube.com/watch?v=XNwL_9ur8R8

  ///Note: This widget may not work due to the plugin update
  Widget staggaredColorGrid() {
    return Expanded(
      child: StaggeredGrid.count(
        // shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: events.map((InterlacedEvent event){
           int index = events.indexOf(event);
          return eventContainer(event, index);
        }).toList()
        
        // staggeredTileBuilder: (int index) {
        //   double height = 120;
        //   if (events[index].endingTime == null) height = 60;
        //   if (index == 3) height = 180;
        //   return StaggeredTile.extent(2, height);
        // },
      ),
    );
  }

  Widget eventContainer(InterlacedEvent event, int index) {
    bool clicked = selectedEventContainers.contains(index);
    Color color = clicked ? event.color : Colors.grey;
    return InkWell(
      splashColor: color,
      highlightColor: color,
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        setState(() {
          clicked ? selectedEventContainers.remove(index) : selectedEventContainers.add(index);
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            eventTimes(event, color),
            eventTitle(event.title),
            if (event.endingTime != null) avatarRows(event),
          ],
        ),

        //decoration
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
          color: color.withAlpha(20),
        ),
      ),
    );
  }

  Widget eventTimes(InterlacedEvent event, Color color) {
    return Row(
      children: [
        eventTime(event.startingTime, color),
        event.endingTime != null ? eventTime(event.endingTime, color) : eventAvatar(event.avatar1),
        if (event.endingTime == null) eventAvatar(event.avatar2),
      ],
    );
  }

  Widget eventTime(String? time, Color color) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        child: Txt(
          text: time,
          fontSize: 10,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget eventAvatar(String avatar) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(avatar),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget eventTitle(String title) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Txt(
        text: title,
        fontSize: 10,
        textAlign: TextAlign.start,
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget avatarRows(InterlacedEvent event) {
    return Row(
      children: [
        eventAvatar(event.avatar1),
        eventAvatar(event.avatar2),
      ],
    );
  }

  static List<IconLabel> iconLabels = [
    IconLabel(Icons.event, "Calendars"),
    IconLabel(Icons.cloud, "Files"),
    IconLabel(Icons.people, "Teams"),
    IconLabel(Icons.build, "Settings"),
    IconLabel(Icons.dashboard, "Dashboard"),
    IconLabel(Icons.insert_drive_file, "Invoice"),
    IconLabel(Icons.local_fire_department, "Events"),
    IconLabel(Icons.forum, "Message"),
  ];

  static List<String> ywmdList = ["Year", "Week", "Month", "Day"];

  static List<InterlacedEvent> events = [
    InterlacedEvent(Colors.green, "Shooting Stars", "09:00", "11:00", Urls.avatar1, Urls.avatar2),
    InterlacedEvent(
        Colors.deepOrange, "The Amazing Hubble", "11:00", null, Urls.avatar3, Urls.avatar2),
    InterlacedEvent(Colorz.interlacedChatPurple, "Choosing A Quality Cookware Set", "13:00",
        "15:00", Urls.avatar1, Urls.avatar3),
    InterlacedEvent(Colors.pink, "Astronomy Binoculars A Great Alternative", "15:00", "17:59",
        Urls.avatar3, Urls.avatar1),
    InterlacedEvent(Colors.blue, "The Amaing Hubble 2", "13:00", null, Urls.avatar3, Urls.avatar2),
  ];
}

/*
A̶v̶a̶t̶a̶r̶ 
U̶s̶e̶r̶T̶i̶l̶e̶
h̶o̶r̶i̶z̶o̶n̶t̶a̶l̶G̶r̶i̶d̶
A̶v̶a̶t̶a̶r̶T̶i̶n̶y̶,̶ C̶h̶i̶p̶,̶ C̶h̶a̶t̶ B̶u̶t̶t̶o̶n̶,̶
S̶e̶a̶r̶c̶h̶,̶ L̶o̶c̶a̶t̶i̶o̶n̶,̶ F̶a̶c̶e̶ C̶h̶i̶p̶s̶,̶
C̶o̶l̶o̶r̶G̶r̶i̶d̶
*/

// USE THE BELOW IF YOU WANT THE SAME RESULT FOR 'horizontalGrid' AS SHOWN IN THE DESIGN
//BUT I'M NOT SATISFIED WITH THE POPED UP VIEW, SO STICKING WITH THE BASIC
// import 'package:flutter/material.dart';
// import 'package:fluttership/Constants/Constants.dart';
// import 'package:fluttership/Models/IconLabel.dart';
// import 'package:fluttership/Widgets/Widgets.dart';

// class InterLacedDashBoard extends StatefulWidget {
//   const InterLacedDashBoard({ Key? key }) : super(key: key);

//   @override
//   _InterLacedDashBoardState createState() => _InterLacedDashBoardState();
// }

// class _InterLacedDashBoardState extends State<InterLacedDashBoard> {

//   IconLabel selectedIconLabel;//helps to indetify which horizontal //grid is selected

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(),
//       body: body(),
//       backgroundColor: Colorz.interlacedBackground,
//     );
//   }

//   Widget appBar(){
//     return AppBar(
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back_ios,color: Colors.grey),
//         onPressed: (){
//           Navigator.of(context).pop();
//         }
//       ),
//       backgroundColor: Colorz.interlacedBackground,
//     );
//   }

//  Widget body(){
//    return ListView(
//      shrinkWrap: true, //we use grid inside this list so...
//      physics: BouncingScrollPhysics(),
//      padding: EdgeInsets.all(12),
//      children: [
//        avatar(size:150),
//        userTile(),
//        horzontalGridStack(),
//      ]
//    );
//  }

//   Widget avatar({double size}){
//     return Container(
//       // radius: radius??50,
//       height: size??50,
//       width: size??50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.black,
//         border: Border.all(
//           width: 3,
//           color: Colorz.interlacedAvatarBorderBlue,
//         ),
//         image: DecorationImage(
//          image: NetworkImage(Urls.interlacedDashBoardAvatar),
//         fit: BoxFit.contain, //in realtime you will use an image cropper for 1:1 so use BoxFit.fill
//         ),
//       ),
//     );
//   }

//   Widget userTile(){
//     return ListTile(
//       title: Txt(
//         text: "Hello Rosalie",
//         color: Colors.blueGrey,
//         textAlign: TextAlign.center,
//         fontWeight: FontWeight.bold,
//       ),
//       subtitle: Txt(
//         text: "rosalie.rice@gmail.com",
//         textAlign: TextAlign.center,
//         color: Colors.grey.shade400,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget horzontalGridStack(){
//     return Stack(
//       children:[
//         horizontalGrid(),//bottom
//         horizontalGrid(visibleOnlyWhenPressed:true),//top only used when a child is selected
//       ]
//     );
//   }

//   Widget horizontalGrid({bool visibleOnlyWhenPressed=false}){
//     // as the object has an icon and a lable, let us use a class

//     return GridView.builder(
//       shrinkWrap: true,
//       padding: EdgeInsets.symmetric(vertical:18),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         childAspectRatio: visibleOnlyWhenPressed? 0.95:1,
//       ),
//       itemCount: iconLabels.length,
//       itemBuilder: (context, int index){
//         BorderRadius _borderRadius;
//         Radius corner = Radius.circular(12);//you can set as 20
//         switch (index) {
//           case 0: _borderRadius = BorderRadius.only(topLeft: corner);
//           break;
//           case 3: _borderRadius = BorderRadius.only(topRight: corner);
//           break;

//           case 4: _borderRadius = BorderRadius.only(bottomLeft: corner);
//           break;
//           case 7: _borderRadius = BorderRadius.only(bottomRight: corner);
//           break;
//           // default: _borderRadius = null;
//         }

//         IconLabel iL = iconLabels[index];

//         bool selected = selectedIconLabel == iL;

//         if(visibleOnlyWhenPressed){
//           return selectedHorizontalGridChild(iL,selected);
//         }else{
//           return horizontalGridChild(iL,borderRadius: _borderRadius);
//         }

//       }
//     );
//   }

//   Widget horizontalGridChild(IconLabel iconLabel,{BorderRadius borderRadius,  }){

//     return AnimatedContainer(
//       duration: Duration(seconds:1),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//          border: Border.all(
//            width: 0.25,
//            color: Colors.grey.shade400,
//          ),
//         borderRadius: borderRadius,
//       ),
//       child: InkWell(
//         onTap: ()=>selectHorizontalGridChildFn(iconLabel),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(iconLabel.icon,color: Colors.grey),
//             Txt(
//               text: iconLabel.label,
//               color: Colors.grey,
//               fontWeight: FontWeight.normal,
//           ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget selectedHorizontalGridChild(IconLabel iconLabel,bool isSelected){
//     return AnimatedContainer(
//       duration: Duration(milliseconds:500),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: isSelected? Colors.white:null,
//         borderRadius:BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: ()=>selectHorizontalGridChildFn(iconLabel),
//         child: isSelected? Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               height: 15,
//               width: 50,
//               // color: Colors.red.shade100,
//               alignment: Alignment.centerRight,
//               child: Icon(Icons.brightness_1,color: Colors.red,
//               size:5,
//               ),
//             ),
//             Icon(iconLabel.icon,color: Colors.blue.shade700 ),
//             Txt(
//               text: iconLabel.label,
//               color: Colors.blueGrey,
//               fontWeight:FontWeight.bold,
//           ),
//           ],
//         ):null,
//       ),
//     );
//   }

//  static List<IconLabel> iconLabels = [
//       IconLabel(Icons.event, "Calendars"),
//       IconLabel(Icons.cloud, "Files"),
//       IconLabel(Icons.people, "Teams"),
//       IconLabel(Icons.build, "Settings"),

//       IconLabel(Icons.dashboard, "Dashboard"),
//       IconLabel(Icons.insert_drive_file, "Invoice"),
//       IconLabel(Icons.local_fire_department, "Events"),
//       IconLabel(Icons.forum, "Message"),

//     ];

//     void selectHorizontalGridChildFn(IconLabel iconLabel)=> setState(()=>selectedIconLabel = iconLabel);//just to show the different approach of selection

// }

/*
A̶v̶a̶t̶a̶r̶ 
U̶s̶e̶r̶T̶i̶l̶e̶
horizontalGrid
AvatarTiny, Chip, Chat Button,
Search, Location, Face Chips,
ColorGrid
*/
