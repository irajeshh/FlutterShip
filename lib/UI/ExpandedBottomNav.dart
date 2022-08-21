import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/CDM.dart';
import 'package:fluttership/Models/IconLabel.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class ExpandedBottomNavigationBarPage extends StatefulWidget {
  const ExpandedBottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  _ExpandedBottomNavigationBarPageState createState() => _ExpandedBottomNavigationBarPageState();
}

class _ExpandedBottomNavigationBarPageState extends State<ExpandedBottomNavigationBarPage> {
  int currentIndex = 0;
  // bool expanded = false;
  // IconLabel selectedIconLabel;
  bool showTopMenu = false;
  double totalheight = 70;
  bool showTopMenusSubMenus = false;

  final PageController pageController = PageController();

  @override
  void initState() {
    // showBottomNav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      //  bottomNavigationBar: expandedBottomnav(),
      backgroundColor: Colorz.compexDrawerCanvasColor,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(text: "Expanded BottomNav"),
      backgroundColor: Colorz.complexDrawerBlack,
    );
  }

  Widget body() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        pageViewBuilder(),
        expandedBottomnav(),
        if (showTopMenu) topMenu(),
      ],
    );
  }

  Widget pageViewBuilder() {
    return PageView.builder(
        controller: pageController,
        // physics: NeverScrollableScrollPhysics(),//do not change it to achive youtube style
        physics: BouncingScrollPhysics(),
        onPageChanged: onPageChanged,
        itemCount: iconLables.length,
        itemBuilder: (context, int index) {
          IconLabel iconLabel = iconLables[index];
          return page(iconLabel);
        });
  }

  Widget page(IconLabel iconLabel) {
    return Center(
      child: ListTile(
        title: Icon(iconLabel.icon, size: 150),
        subtitle: Txt(
          text: "${iconLabel.label} page is Selected",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget expandedBottomnav() {
    return AnimatedContainer(
      height: totalheight,
      alignment: Alignment.center,
      duration: duration,
      color: Colorz.complexDrawerBlack,
      child: column(),
    );
  }

  Widget column() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // divider(),
        primaryMenu(),
        if (totalheight > 70) subMenu(),
      ],
    );
  }

  // Widget divider(){
  //   return AnimatedContainer(
  //     duration: duration,
  //     height: totalheight==70? 3:1,
  //     width: totalheight==70? 35:1,
  //     decoration: BoxDecoration(
  //       color: totalheight==70?Colors.blue:Colors.transparent,
  //       borderRadius: BorderRadius.circular(4),
  //     ),
  //   );
  // }

  Widget primaryMenu() {
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: iconLables.map((iL) {
            return iconLabelButton(iL);
          }).toList()),
    );
  }

  Widget iconLabelButton(IconLabel iconLabel) {
    int index = iconLables.indexOf(iconLabel);
    bool selected = currentIndex == index;
    Color color = selected ? Colors.white : Colors.white54;
    return AnimatedContainer(
      duration: duration,
      padding: EdgeInsets.only(left: 8, right: 8, top: 4),
      decoration: BoxDecoration(
        color: (totalheight > 70 && selected) ? Colorz.timerBlue : Colorz.complexDrawerBlack,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
      ),
      child: GestureDetector(
        onDoubleTap: () => showHideTopMenu(index),
        onTap: () => onIconLabelSelected(index),
        onVerticalDragUpdate: (details) => onDragged(details, index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconLabel.icon, color: color),
            Txt(text: iconLabel.label, color: color),
          ],
        ),
      ),
    );
  }

  Widget subMenu() {
    Widget selectedSubMenuWidget = Container(height: 0);
    switch (currentIndex) {
      case 0:
        selectedSubMenuWidget = subMenuWidget0();
        break;

      case 2:
        selectedSubMenuWidget = subMenuWidget2();
        break;

      case 3:
        selectedSubMenuWidget = subMenuWidget3();
        break;

      default:
        selectedSubMenuWidget = Container(height: 0);
    }
    return Expanded(
        child: AnimatedContainer(
      duration: duration,
      color: totalheight > 70 ? Colorz.timerBlue : Colorz.complexDrawerBlack,
      child: selectedSubMenuWidget,
    ));
  }

  Widget subMenuWidget0() {
    List<String> tags = [
      "All",
      "Cinema",
      "Cars",
      "Languages",
      "Flutter",
      "Android",
      "Love",
      "Inspiration",
    ];

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, int index) {
          String tag = tags[index];

          return Container(
            height: 24,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 24,
              child: Txt(
                text: tag,
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colorz.complexDrawerBlueGrey,
                borderRadius: BorderRadius.circular(360),
              ),
            ),
          );
        });
  }

  Widget subMenuWidget2() {
    List<IconLabel> channels = [
      IconLabel(Icons.favorite, "Love"),
      IconLabel(Icons.person, "Alone"),
      IconLabel(Icons.search, "Bing"),
      IconLabel(Icons.settings, "Mechanical"),
      IconLabel(Icons.menu, "Drawing"),
      IconLabel(Icons.person, "Alone"),
    ];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
      ),
      itemCount: channels.length,
      itemBuilder: (BuildContext context, int index) {
        // return FlatButton(onPressed: onPressed, child: child);
        // let us use our own button
        IconLabel channel = channels[index];
        return Button(
          icon: channel.icon,
          text: channel.label,
          buttonColor: Colors.blue,
          onPressed: () {
            print("A Channel is selected");
          },
        );
      },
    );
  }

  Widget subMenuWidget3() {
    List<String> avatars = [
      Urls.avatar1,
      Urls.avatar2,
      Urls.avatar3,
      Urls.avatar4,
      Urls.avatar1,
      Urls.avatar2,
      Urls.avatar3,
      Urls.avatar4,
    ]..shuffle();

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 4),
      scrollDirection: Axis.horizontal,
      itemCount: avatars.length,
      itemBuilder: (context, int index) {
        String url = avatars[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  Widget topMenu() {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceAround;
    if (currentIndex == 0) mainAxisAlignment = MainAxisAlignment.start;
    if (currentIndex == 3) mainAxisAlignment = MainAxisAlignment.end;
    return Padding(
      padding: EdgeInsets.only(bottom: totalheight),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: topMenus.map((cdm) {
          int index = topMenus.indexOf(cdm);
          bool show = currentIndex == index;
          return show ? topMenuWithItsSubmenu(topMenus[index]) : Container();
        }).toList(),
      ),
    );
  }

  Widget topMenuWithItsSubmenu(CDM cdm) {
    String topMenuTitle = cdm.title;
    List<String> submenus = cdm.submenus;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (currentIndex >= 2 && showTopMenusSubMenus) subMenuWidget(submenus),
        topMenuButton(topMenuTitle),
        if (currentIndex < 2 && showTopMenusSubMenus) subMenuWidget(submenus),
      ],
    );
  }

  Widget topMenuButton(String topMenuTitle) {
    BorderRadius borderRadius = BorderRadius.circular(8);
    if (currentIndex == 1) borderRadius = BorderRadius.only(topLeft: Radius.circular(8));
    if (currentIndex == 2) borderRadius = BorderRadius.only(topRight: Radius.circular(8));

    if (showTopMenusSubMenus == false) {
      if (currentIndex == 1 || currentIndex == 2)
        borderRadius = BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8));
      if (currentIndex == 0) borderRadius = BorderRadius.only(topRight: Radius.circular(8));
      if (currentIndex == 3) borderRadius = BorderRadius.only(topLeft: Radius.circular(8));
    }

    return InkWell(
      borderRadius: borderRadius,
      onTap: showHideTopSubMenus,
      child: Container(
        decoration: BoxDecoration(
          color: Colorz.complexDrawerBlueGrey,
          borderRadius: borderRadius,
        ),
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (currentIndex >= 2) Icon(Icons.navigate_before, color: Colors.white),
            Txt(text: topMenuTitle, fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            if (currentIndex < 2) Icon(Icons.navigate_next, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus) {
    //  return CircleAvatar();
    return Container(
      height: submenus.length.toDouble() * 35,
      width: 100,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          color: Colorz.complexDrawerBlueGrey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: submenus.length,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return Container(
              child: Txt(
                text: subMenu,
                color: Colors.white70,
              ),
              padding: EdgeInsets.all(8),
            );
          }),
    );
  }

  //you can use this widget to find the size of the child
  // Widget measuredSize(Widget child){
  //   return MeasuredSize(
  //             onChange: (Size size) {
  //               setState((){
  //                 totalheight = size.height + 75; //75 for a normal bottom nav
  //               });
  //             },
  //             child: child,
  //           );
  // }

  static const Duration duration = Duration(milliseconds: 350);

  static List<IconLabel> iconLables = [
    IconLabel(Icons.home, "Home"),
    IconLabel(Icons.play_arrow, "Shorts"),
    IconLabel(Icons.subscriptions, "Subscriptions"),
    IconLabel(Icons.video_library, "Library"),
  ];

  static List<CDM> topMenus = [
    CDM(Icons.home, "Home Menu", ["Post", "Video", "Trending", "Explore"]),
    CDM(Icons.play_arrow, "Shorts Menu", ["Create", "My Shorts", "Popular", "New"]),
    CDM(Icons.subscriptions, "Subscriptions Menu", [
      "Old",
      "A-z",
      "Z-A",
    ]),
    CDM(Icons.video_library, "Library Menu", [
      "History",
      "Liked",
      "Watchlater",
    ]),
  ];

  // void showBottomNav()async{
  //   await Future.delayed(duration2);
  //   setState(()=> totalheight = 75);
  // }

  void onDragged(details, int index) {
    int sensitivity = 8;
    if (details.delta.dy > sensitivity) {
      shrinkTo70(index);
    } else if (details.delta.dy < -sensitivity) {
      expandHeight(index);
    }
  }

  void onIconLabelSelected(int index) {
    //if already in expanded state and a button is pressed,
    //if same button is pressed, don't do anything, otherwise shink the submenu

    // bool sameIconSelected = currentIndex == index;
    // if(sameIconSelected==false) totalheight = 70;
    // setState(()=>currentIndex = index);

    currentIndex = index;
    pageController.jumpToPage(index);
    setState(() {});
  }

  void changeHeightFn(int index) {
    bool sameIconSelection = currentIndex == index;
    sameIconSelection ? shrinkTo70(index) : expandHeight(index);
  }

  void expandHeight(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        totalheight = 70 + 24.0;
        break;
      case 2:
        totalheight = 70 + 120.0;
        break;
      case 3:
        totalheight = 70 + 53.0; //45 for list view and 8 for vertical padding,
        break;
      default:
        totalheight = 70;
    }
    setState(() {});
  }

  void shrinkTo70(int index) {
    currentIndex = index;
    totalheight = 70;
    setState(() {});
  }

  void showHideTopMenu(int index) {
    showTopMenu = !showTopMenu;
    onIconLabelSelected(index);
  }

  void showHideTopSubMenus() {
    setState(() {
      showTopMenusSubMenus = !showTopMenusSubMenus;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      currentIndex = page;
    });
  }

/*
   Double Tap An Icon to see or hide it's Top Menus With It's Top Sub Menus

          Drag Up An Icon to see it's subMenu

          Drag Down An Icons to hide it's submenu
*/
}
