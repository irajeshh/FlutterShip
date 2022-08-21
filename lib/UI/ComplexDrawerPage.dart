import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/CDM.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class ComplexDrawerPage extends StatefulWidget {
  const ComplexDrawerPage({Key? key}) : super(key: key);

  @override
  _ComplexDrawerPageState createState() => _ComplexDrawerPageState();
}

class _ComplexDrawerPageState extends State<ComplexDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      drawer: ComplexDrawer(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colorz.compexDrawerCanvasColor,
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: IconTheme.of(context).copyWith(
        color: Colorz.complexDrawerBlack,
      ),
      title: Txt(
        text: "Complex Drawer",
        color: Colorz.complexDrawerBlack,
      ),
      backgroundColor: Colorz.compexDrawerCanvasColor,
    );
  }

  Widget body() {
    return Center(
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: Colorz.complexDrawerBlack,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: FlutterLogo(
          size: 150,
        ),
      ),
    );
  }
}

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  int selectedIndex = -1; //dont set it to 0

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: row(),
      color: Colorz.compexDrawerCanvasColor,
    );
  }

  Widget row() {
    return Row(children: [
      isExpanded ? blackIconTiles() : blackIconMenu(),
      invisibleSubMenus(),
    ]);
  }

  Widget blackIconTiles() {
    return Container(
      width: 200,
      color: Colorz.complexDrawerBlack,
      child: Column(
        children: [
          controlTile(),
          Expanded(
            child: ListView.builder(
              itemCount: cdms.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();

                CDM cdm = cdms[index];
                bool selected = selectedIndex == index;
                return ExpansionTile(
                    onExpansionChanged: (z) {
                      setState(() {
                        selectedIndex = z ? index : -1;
                      });
                    },
                    leading: Icon(cdm.icon, color: Colors.white),
                    title: Txt(
                      text: cdm.title,
                      color: Colors.white,
                    ),
                    trailing: cdm.submenus.isEmpty
                        ? null
                        : Icon(
                            selected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                    children: cdm.submenus.map((subMenu) {
                      return sMenuButton(subMenu, false);
                    }).toList());
              },
            ),
          ),
          accountTile(),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: ListTile(
        leading: FlutterLogo(),
        title: Txt(
          text: "FlutterShip",
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        onTap: expandOrShrinkDrawer,
      ),
    );
  }

  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 100,
      color: Colorz.complexDrawerBlack,
      child: Column(
        children: [
          controlButton(),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (contex, index) {
                  // if(index==0) return controlButton();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Icon(cdms[index].icon, color: Colors.white),
                    ),
                  );
                }),
          ),
          accountButton(),
        ],
      ),
    );
  }

  Widget invisibleSubMenus() {
    // List<CDM> _cmds = cdms..removeAt(0);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: isExpanded ? 0 : 125,
      color: Colorz.compexDrawerCanvasColor,
      child: Column(
        children: [
          Container(height: 95),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (context, index) {
                  CDM cmd = cdms[index];
                  // if(index==0) return Container(height:95);
                  //controll button has 45 h + 20 top + 30 bottom = 95

                  bool selected = selectedIndex == index;
                  bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
                  return subMenuWidget([cmd.title]..addAll(cmd.submenus), isValidSubMenu);
                }),
          ),
        ],
      ),
    );
  }

  Widget controlButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
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

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 37.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu ? Colorz.complexDrawerBlueGrey : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return sMenuButton(subMenu, index == 0);
          }),
    );
  }

  Widget sMenuButton(String subMenu, bool isTitle) {
    return InkWell(
      onTap: () {
        //handle the function
        //if index==0? donothing: doyourlogic here
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Txt(
          text: subMenu,
          fontSize: isTitle ? 17 : 14,
          color: isTitle ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget accountButton({bool usePadding = true}) {
    return Padding(
      padding: EdgeInsets.all(usePadding ? 8 : 0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white70,
          image: DecorationImage(
            image: NetworkImage(Urls.avatar2),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget accountTile() {
    return Container(
      color: Colorz.complexDrawerBlueGrey,
      child: ListTile(
        leading: accountButton(usePadding: false),
        title: Txt(
          text: "Prem Shanhi",
          color: Colors.white,
        ),
        subtitle: Txt(
          text: "Web Designer",
          color: Colors.white70,
        ),
      ),
    );
  }

  static List<CDM> cdms = [
    // CDM(Icons.grid_view, "Control", []),

    CDM(Icons.grid_view, "Dashboard", []),
    CDM(Icons.subscriptions, "Category", ["HTML & CSS", "Javascript", "PHP & MySQL"]),
    CDM(Icons.markunread_mailbox, "Posts", ["Add", "Edit", "Delete"]),
    CDM(Icons.pie_chart, "Analytics", []),
    CDM(Icons.trending_up, "Chart", []),

    CDM(Icons.power, "Plugins", ["Ad Blocker", "Everything Https", "Dark Mode"]),
    CDM(Icons.explore, "Explore", []),
    CDM(Icons.settings, "Setting", []),
  ];

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
