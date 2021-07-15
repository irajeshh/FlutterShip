import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/Clone.dart';
import 'package:fluttership/UI/Account.dart';
import 'package:fluttership/UI/GoogleSearchPage.dart';
import 'package:fluttership/UI/SendMoneyPage.dart';
import 'package:fluttership/UI/TimerDrawerPage.dart';
import 'package:fluttership/Widgets/Widgets.dart';

import 'UI/CurrenciesPage.dart';
import 'UI/ScrollerSamplePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController searchController = TextEditingController();
  String query = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }


  Widget body(){
    return Column(
      children: [
        searchField(),
        clonesResult(),
      ],
    );
  }

  Widget searchField(){
    return Padding(
      padding: const EdgeInsets.only(top:28, bottom: 8),
      child: Card(
        elevation: 0,
        color: Colors.grey.shade50,
        child: ListTile(
          leading: Icon(Icons.search, color: Colors.grey),
          title: TextField(
            controller: searchController,
            onChanged: (z)=>setState(()=>query = z.toLowerCase()),
            decoration: InputDecoration(
              hintText: "Search FlutterShip...",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
          ),
          trailing: IconButton(onPressed: clearSearch, icon: Icon(Icons.clear,color: Colors.grey)),
        ),
      ),
    );
  }


  Widget clonesResult(){  
     List<Clone> _clones = clones.where((clone){
       return clone.title.toString().toLowerCase().contains(query) || clone.title.toString().toLowerCase().contains(query);
     }).toList();
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: false,
          itemCount: _clones.length,
          itemBuilder: (BuildContext context, int index) {
            Clone clone = _clones[index];
          return ColorTile(
            icon: clone.icon,
            color: clone.color,
            title: clone.title,
            subtitle: clone.subtitle,
            onTap: (){
              Widgets.instance.push(clone.page,context);
            }
          );
         },
        ),
    );
  }



  List<Clone> clones = [
    Clone(TimerDrawerPage(), Colorz.timerBlue, Icons.calendar_today, "Timer Drawer", "Simple clean drawer design from dribbble.com"),
    Clone(AccountPage(), Colors.pink, Icons.person, "Account Page", "Colorful & BW Account Dashboard"),
    Clone(CurrenciesPage(), Colors.green, Icons.monetization_on, "Currency page", "Crypto currency coins app design dribbble.com"),
    Clone(SendMoneyPage(), Colorz.sendMoneyBlue, Icons.dialpad,"Send Money", "Money transfer screen design from dribbble.com"),
    Clone(ScrollerSamplePage(), Colors.blue, Icons.list, "Scroller Sample", "Example use case of scroller widget"),
    Clone(GoogleSearchPage(), Colors.amber, Icons.search, "Google Search Clone", "Cloing a google search results page"),
    
  ];


  void clearSearch(){
    searchController.clear();
    query = '';
    FocusScope.of(context).unfocus();
  }



 


}