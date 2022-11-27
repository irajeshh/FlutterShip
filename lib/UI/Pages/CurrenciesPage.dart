import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/Currency.dart';
import 'package:fluttership/Models/IconLabel.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class CurrenciesPage extends StatefulWidget {
  const CurrenciesPage({Key? key}) : super(key: key);

  @override
  _CurrenciesPageState createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {
  final ScrollController _scrollController = ScrollController();
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorz.currenciesPageBackground,
      appBar: AppBar(
        backgroundColor: Colorz.currenciesPageBackground,
      ),
      body: listView(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  // Widget body(){
  //   return Column(
  //     children: [
  //       Flexible(
  //         child: listView()
  //       ),
  //       bottomNavigationBar(),
  //     ]
  //   );
  // }

  Widget listView() {
    //To get bouncing effect, we use listview
    return Scroller(
      // useScrollIndicator: false,
      scrollController: _scrollController,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.end,
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        children: currencies.map((currency) => tile(currency)).toList(),
      ),
    );
  }

  Widget tile(Currency currency) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: leadingCircle(currency),
        title: titleTxt(currency.title),
        subtitle: subtitleTxt(currency),
      ),
    );
  }

  Widget leadingCircle(Currency currency) {
    return Container(
      height: 55,
      width: 55,
      child: Icon(currency.icon, color: Colors.white, size: 34),
      decoration: BoxDecoration(
          border: Border.all(
            color: currency.borderColor,
            width: 2,
          ),
          color: Colorz.currenciesPageBackground,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: currency.borderColor,
              blurRadius: 1,
              // spreadRadius: 0.5,
            )
          ]),
    );
  }

  Widget titleTxt(String title) {
    return Txt(
      text: title,
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: Colorz.currenciesNameColor,
    );
  }

  Widget subtitleTxt(Currency currency) {
    //we can try Row or RichText, let see which one is enough
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Txt(
          text: currency.subTitle,
          fontSize: 20,
          color: Colors.white,
        ),
        lable(currency.percentage, currency.negative),
      ],
    );
  }

  Widget lable(double percent, bool negative) {
    return Container(
      child: Txt(
        text: '${negative ? '-' : '+'}$percent%',
        fontSize: 12.5,
      ),
      margin: const EdgeInsets.only(left: 8.0),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: negative ? Colors.red : Colorz.currencyPositiveGreen,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: iconLabels
          .map((iconLabel) => item(iconLabel, iconLabels.indexOf(iconLabel) == currentIndex))
          .toList(),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colorz.currenciesNameColor,
      backgroundColor: Colorz.currenciesPageBackground,
    );
  }

  BottomNavigationBarItem item(IconLabel iconLabel, bool selected) {
    return BottomNavigationBarItem(
        backgroundColor: Colorz.currenciesPageBackground,
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            indicator(selected),
            Icon(iconLabel.icon),
          ],
        ),
        label: iconLabel.label);
  }

  Widget indicator(bool selected) {
    Color color = selected ? Colorz.currencyIndicatorColor : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        height: 2.5, // selected? 2.5:0, let us keep it as fixed
        width: selected ? 70 : 0,
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(color: color, boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 2.25,
            spreadRadius: 0,
          ),
        ]),
      ),
    );
  }

  void onTap(int index) {
    setState(() => currentIndex = index);
  }

  static List<Currency> currencies = [
    Currency("Gemini Dollar (GUSD)", "\$7,312.00", 0.21, true, Icons.all_inclusive_outlined,
        Colors.cyan),
    Currency("Basic Attention Token", "\$1,411.00", 0.11, false, Icons.change_history_outlined,
        Colors.pink),
    Currency(
        "Bitcoin (BTC)", "\$9,299.00", 0.51, false, Icons.monetization_on_outlined, Colors.yellow),
    Currency("Basic Attention Token", "\$1,411.00", 0.11, false, Icons.change_history_outlined,
        Colors.pink),
    Currency(
        "Bitcoin (BTC)", "\$9,299.00", 0.51, false, Icons.monetization_on_outlined, Colors.yellow),
    Currency(
        "Bitcoin (BTC)", "\$9,299.00", 0.51, false, Icons.monetization_on_outlined, Colors.yellow),
    Currency("Basic Attention Token", "\$1,411.00", 0.11, false, Icons.change_history_outlined,
        Colors.pink),
    Currency("Gemini Dollar (GUSD)", "\$7,312.00", 0.21, true, Icons.all_inclusive_outlined,
        Colors.cyan),
    Currency(
        "Bitcoin (BTC)", "\$9,299.00", 0.51, false, Icons.monetization_on_outlined, Colors.yellow),
    Currency("Gemini Dollar (GUSD)", "\$7,312.00", 0.21, true, Icons.all_inclusive_outlined,
        Colors.cyan),
    Currency("Gemini Dollar (GUSD)", "\$7,312.00", 0.21, true, Icons.all_inclusive_outlined,
        Colors.cyan),
    Currency("Basic Attention Token", "\$1,411.00", 0.11, false, Icons.change_history_outlined,
        Colors.pink),
    Currency("Gemini Dollar (GUSD)", "\$7,312.00", 0.21, true, Icons.all_inclusive_outlined,
        Colors.cyan),
    Currency(
        "Bitcoin (BTC)", "\$9,299.00", 0.51, false, Icons.monetization_on_outlined, Colors.yellow),
    Currency("Basic Attention Token", "\$1,411.00", 0.11, false, Icons.change_history_outlined,
        Colors.pink),
  ];

  static List<IconLabel> iconLabels = [
    IconLabel(Icons.cached, "Exchange"),
    IconLabel(Icons.show_chart_outlined, "Analytics"),
    IconLabel(Icons.devices_outlined, "Currencies"),
    IconLabel(Icons.more_horiz_outlined, "More"),
  ];
}



//let us define those parameters into a class
