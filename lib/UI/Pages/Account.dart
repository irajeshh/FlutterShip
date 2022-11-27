import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
          0xffffffff), //you can paste your custom code color, but this one is for demo purpose,
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(), //use this for a bouncing experience
        children: [
          Container(height: 35),
          userTile(),
          divider(),
          colorTiles(),
          divider(),
          bwTiles(),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
      // floatingActionButton: fab(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget userTile() {
    //I use pixabay.com & unsplash.com for most of the time.
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(Urls.avatar1),
      ),
      title: Txt(
        text: "Talan Lipshutz",
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(text: "UX Designer"),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        colorTile(Icons.person_outline, Colors.deepPurple, "Personal data"),
        colorTile(Icons.settings_outlined, Colors.blue, "Settings"),
        colorTile(Icons.credit_card, Colors.pink, "Payment"),
        colorTile(Icons.favorite_border, Colors.orange, "Personal data"),
      ],
    );
  }

  Widget bwTiles() {
    // Color color = Colors.blueGrey.shade800; not satisfied, so let us pick it
    return Column(
      children: [
        bwTile(Icons.info_outline, "FAQs"),
        bwTile(Icons.border_color_outlined, "Handbook"),
        bwTile(Icons.textsms_outlined, "Community"),
      ],
    );
  }

//only for ease of understanding, other wise you can use colorTile Directly,
// in my preference, i split the widgets into as many chunks as possible

  Widget bwTile(IconData icon, String text) {
    return colorTile(icon, Colors.black, text, blackAndWhite: true);
  }

  Widget colorTile(IconData icon, Color color, String text, {bool blackAndWhite = false}) {
    Color pickedColor = Color(0xfff3f4fe);
    return ListTile(
      leading: Container(
        child: Icon(icon, color: color),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: blackAndWhite ? pickedColor : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Txt(
        text: text,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      onTap: () {},
    );
  }

  Widget bottomNavigationBar() {
    List<IconData> icons = [
      Icons.home,
      Icons.search,
      Icons.add,
      Icons.notifications,
      Icons.person_outline,
    ];

    return BottomNavigationBar(
      currentIndex: 2,
      items: icons.map((icon) => item(icon)).toList(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: Colorz.accountPurple,
      unselectedItemColor: Colors.grey,
    );
  }

  BottomNavigationBarItem item(
    IconData icon,
  ) {
    return BottomNavigationBarItem(
      icon: icon == Icons.add ? addButton() : Icon(icon),
      label: "label",
    );
  }

  Widget addButton() {
    return CircleAvatar(
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colorz.accountPurple,
    );
  }

  // Widget fab(){
  //   //this is not satisfying for
  //   // return FloatingActionButton(
  //   //   mini: true,
  //   //   child: Icon(Icons.add,
  //   //   color: Colors.white),
  //   //   onPressed: () {},
  //   // );
  // }
}
