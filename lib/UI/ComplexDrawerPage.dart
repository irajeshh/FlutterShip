import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/CDM.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class ComplexDrawerPage extends StatefulWidget {
  const ComplexDrawerPage({ Key key }) : super(key: key);

  @override
  _ComplexDrawerPageState createState() => _ComplexDrawerPageState();
}

class _ComplexDrawerPageState extends State<ComplexDrawerPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: appBar(),
     drawer: ComplexDrawer(),
     drawerScrimColor: Colors.transparent,
     backgroundColor: Colorz.compexDrawerCanvasColor,
  );
  }

  Widget appBar(){
    return AppBar(
      title: Txt(
        text: "Complex Drawer Example",
        color: Colors.black,
      ),
      backgroundColor: Colorz.compexDrawerCanvasColor,
    );
  }
}


class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({ Key key }) : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {

  int selectedIndex = -1;//dont set it to 0

  bool isExpanded = false;


  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Container(
      // width: width,
      child: row(),
    );
  }

  Widget row(){
    return Row(
      children: [
        blackIconMenu(),
        invisibleSubMenus(),
      ]
    );
  }

  Widget blackIconMenu(){
    return Container(
      width: 100,
      color: Colorz.complexDrawerBlack,
      child: ListView.builder(
        itemCount: cdms.length,
        itemBuilder: (contex, index){
            if(index==0) return controlButton();
          return InkWell(
            onTap: (){
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              child: Icon(cdms[index].icon,color: Colors.white),
            ),
          );
        }
      ),
    );
  }

  Widget invisibleSubMenus(){
    // List<CDM> _cmds = cdms..removeAt(0);
    return AnimatedContainer(
      duration: Duration(milliseconds:500),
      width: isExpanded? 0:125,
      color: Colorz.compexDrawerCanvasColor,
      child: ListView.builder(
        itemCount: cdms.length,
        itemBuilder: (context, index){  
          CDM cmd = cdms[index];
          if(index==0) return Container(height:95);  
          //controll button has 45 h + 20 top + 30 bottom = 95    

          bool selected = selectedIndex==index;
          bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
          return subMenuWidget([cmd.title]..addAll(cmd.submenus) ,isValidSubMenu);
        }
      ),
    );
  }


  Widget controlButton(){
    return Padding(
      padding: EdgeInsets.only(top:20,bottom: 30),
      child: InkWell(
        onTap: expandOrShrinkDrawer,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: FlutterLogo(
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus,bool isValidSubMenu){
     return AnimatedContainer(
       duration: Duration(milliseconds:500),
       height: isValidSubMenu? 200 : 45,
       alignment: Alignment.center,
       decoration: BoxDecoration(
         color:isValidSubMenu? Colorz.complexDrawerBlueGrey:
         Colors.transparent,
         borderRadius: BorderRadius.only(
           topRight: Radius.circular(8),
           bottomRight:  Radius.circular(8),
         )
       ),
       child: ListView.builder(
         padding: EdgeInsets.all(6),
                itemCount: isValidSubMenu? submenus.length:0,
                itemBuilder: (context,index){
                  String subMenu = submenus[index];
                  return InkWell(
                    onTap: (){

                      //TODO handle the function
                      //if index==0? donothing: doyourlogic here
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Txt(
                        text: subMenu,
                        fontSize: index==0? 17:14,
                        color: index==0? Colors.white: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              ),
     );
  }

  // Widget invisibleSubMenuWidget(){
  //   return Container(
  //     height: 45,
  //     color: Colors.green,
  //   );
  // }


  // List<IconData> icons = [
  //   Icons.grid_view,
  //   Icons.subscriptions,
  //   Icons.markunread_mailbox,
  //   Icons.pie_chart,
  //   Icons.power,
  //   Icons.explore,
  //   Icons.settings,

  // ];

  static List<CDM> cdms = [
    CDM(Icons.grid_view, "Control", []),
    
    CDM(Icons.grid_view, "Dashboard", []),
    CDM(Icons.subscriptions, "Category", ["HTML & CSS", "Javascript","PHP & MySQL"]),
    CDM(Icons.markunread_mailbox, "Posts", []),
    CDM(Icons.pie_chart, "Analytics", []),
    CDM(Icons.trending_up, "Chart", []),
    
    CDM(Icons.power, "Plugins", []),
    CDM(Icons.explore, "Explore", []),
    CDM(Icons.settings, "Setting", []),
  ];


   void expandOrShrinkDrawer(){
     setState(() {
       isExpanded = !isExpanded;
     });
   }


}