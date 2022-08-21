import 'package:flutter/material.dart';
import 'package:fluttership/Models/Currency.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class AssemblingAnalyticsPage extends StatefulWidget {
  const AssemblingAnalyticsPage({Key? key}) : super(key: key);

  @override
  _AssemblingAnalyticsPageState createState() => _AssemblingAnalyticsPageState();
}

class _AssemblingAnalyticsPageState extends State<AssemblingAnalyticsPage> {
  bool showMoneyTile = false;
  bool showHorizontalCircleLabelsAndBackground = false;

  // List<IconData> horizontalCircleIcons = [];
  List<IconData> horizontalCircleIconsLeft = [];
  List<IconData> horizontalCircleIconsRight = [];
  IconData? selectedHorizontalIcon;
  static const List<String> horizontalCircleLabelsisLeft = [
    "Receive",
    "Send",
  ];
  static const List<String> horizontalCircleLabelsisRight = [
    "Exchange",
    "Cash out",
  ];

  bool showActive = false;
  bool showCurrencyTile1 = false;
  bool showCurrencyTile2 = false;
  bool showNoAnalytics = false;
  bool showCurrencyTile3 = false;
  bool showFab = false;

//keys for animatedlists
  final GlobalKey<AnimatedListState> horizontalCirclesKeyLeft = GlobalKey();
  final GlobalKey<AnimatedListState> horizontalCirclesKeyRight = GlobalKey();

  final GlobalKey<AnimatedListState> primaryListKey = GlobalKey();

  @override
  void initState() {
    startAnimations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: appBar(),
      body: body(),
      floatingActionButton: fab(),
      floatingActionButtonLocation: showFab
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerTop,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.black,
    );
  }

  Widget body() {
    //AnimatedList but later :)
    return ListView(
      children: [
        moneyTile(),
        horizontalCircles(),
        plainTile("Active", showActive),
        currencyTile(0, showCurrencyTile1),
        currencyTile(1, showCurrencyTile2),
        plainTile("No Analytics", showNoAnalytics),
        currencyTile(2, showCurrencyTile3),
      ],
    );
  }

  Widget moneyTile() {
    return AnimatedContainer(
      duration: duration,
      // height: showMoneyTile? 80 : 0,
      padding: EdgeInsets.all(showMoneyTile ? 0 : 50),
      color: showMoneyTile ? Colors.grey.shade900 : Colors.black,
      child: AnimatedOpacity(
        opacity: showMoneyTile ? 1 : 0,
        duration: duration,
        child: ListTile(
          title: Txt(
            text: "\$1,234.63",
            fontSize: 22,
            textAlign: TextAlign.center,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          subtitle: Txt(
            text: "+ \$12.53 today",
            textAlign: TextAlign.center,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget horizontalCircles() {
    return AnimatedContainer(
      duration: duration,
      color: showHorizontalCircleLabelsAndBackground ? Colors.grey.shade900 : Colors.black,
      child: Row(children: [
        horizontalCircleListView(),
        horizontalCircleListView(isLeft: false),
      ]),
    );
  }

  Widget horizontalCircleListView({bool isLeft = true}) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width / 2,
      child: AnimatedList(
        reverse: isLeft,
        key: isLeft ? horizontalCirclesKeyLeft : horizontalCirclesKeyRight,
        scrollDirection: Axis.horizontal,
        initialItemCount: (isLeft ? horizontalCircleIconsLeft : horizontalCircleIconsRight).length,
        itemBuilder: (context, index, animation) {
          IconData icon =
              isLeft ? horizontalCircleIconsLeft[index] : horizontalCircleIconsRight[index];
          return horizontalCircle(index, animation, icon, isLeft);
        },
      ),
    );
  }

  Widget horizontalCircle(int index, Animation<double> animation, IconData icon, bool isLeft) {
    bool selected = selectedHorizontalIcon == icon;
    Color selectedColor = (randomColors..shuffle())[0];
    return AnimatedContainer(
      height: 80,
      width: MediaQuery.of(context).size.width / (animation.value == 0 ? 2 : 4),
      duration: duration,
      alignment: Alignment.center,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: Column(
            children: [
              //circle avatar
              InkWell(
                borderRadius: BorderRadius.circular(360),
                onTap: () {
                  setState(() {
                    selectedHorizontalIcon = selected ? null : icon;
                  });
                },
                child: AnimatedContainer(
                  child:
                      RotationTransition(turns: animation, child: Icon(icon, color: Colors.white)),
                  duration: duration,
                  padding: EdgeInsets.all(animation.value == 0 ? 0 : 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: animation.value == 0
                        ? Colors.grey.shade300
                        : (selected ? selectedColor : Colors.grey.shade700),
                  ),
                ),
              ),
              //label
              AnimatedContainer(
                duration: duration,
                padding: EdgeInsets.all(showHorizontalCircleLabelsAndBackground ? 4 : 0),
                child: AnimatedOpacity(
                  opacity: showHorizontalCircleLabelsAndBackground ? 1 : 0,
                  duration: duration,
                  child: Txt(
                    text: isLeft
                        ? horizontalCircleLabelsisLeft[index]
                        : horizontalCircleLabelsisRight[index],
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget plainTile(String lable, bool visible) {
    return AnimatedContainer(
      duration: duration,
      padding: EdgeInsets.symmetric(vertical: visible ? 12 : 0),
      child: AnimatedOpacity(
        duration: duration,
        opacity: visible ? 1 : 0,
        child: Card(
          color: Colors.grey.shade800,
          child: ListTile(
            title: Txt(
              text: lable,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            trailing: Icon(Icons.arrow_drop_up, size: 32, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget currencyTile(int index, bool showCurrencyTile) {
    Currency currency = currencies[index];
    return AnimatedOpacity(
      duration: duration,
      opacity: showCurrencyTile ? 1 : 0,
      child: AnimatedContainer(
        duration: duration,
        // height: showCurrencyTile?75:0,
        padding: EdgeInsets.only(left: showCurrencyTile ? 0 : 100),
        child: ListTile(
          leading: currencyLeading(currency.icon, currency.borderColor, showCurrencyTile),
          title: Txt(
            text: currency.title,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          subtitle: Txt(
            text: currency.subTitle,
            color: Colors.grey,
          ),
          trailing: currencyTrailing(currency.percentage),
        ),
      ),
    );
  }

  Widget currencyLeading(IconData icon, Color color, bool showCurrencyTile) {
    return AnimatedContainer(
      child: AnimatedOpacity(
          duration: duration,
          opacity: showCurrencyTile ? 1 : 0,
          child: Icon(icon, color: Colors.white)),
      duration: duration,
      padding: EdgeInsets.all(showCurrencyTile ? 8 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(showCurrencyTile ? 360 : 8),
        color: showCurrencyTile ? color : Colors.black,
        gradient: gradient(color),
      ),
    );
  }

  Widget currencyTrailing(double percentage) {
    return Column(
      children: [
        Txt(text: "︿ $percentage%", color: Colors.grey, fontWeight: FontWeight.bold),
        Icon(Icons.insights, color: Colors.grey),
      ],
    );
  }

  Widget fab() {
    return AnimatedContainer(
      duration: duration,
      decoration: BoxDecoration(
        color: showFab ? Colors.black : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: AnimatedContainer(
        duration: duration,
        width: 55,
        height: 55,
        padding: EdgeInsets.all(showFab ? 8 : 25),
        decoration: BoxDecoration(
          color: showFab ? Colors.blue : Colors.transparent,
          shape: BoxShape.circle,
          gradient: gradient(Colors.blue),
        ),
        child: InkWell(
          onTap: () async {
            Navigator.of(context).pop();
            await delay();
          },
          child: AnimatedOpacity(
              duration: duration,
              opacity: showFab ? 1 : 0,
              child: Icon(Icons.add, color: Colors.white)),
        ),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade800,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.signal_cellular_alt_outlined), label: "Analytics"),
          ],
        ));
  }

  LinearGradient gradient(Color color) {
    return LinearGradient(end: Alignment.topRight, begin: Alignment.bottomRight, colors: [
      color.withAlpha(175),
      color,
    ]);
  }

//  static Duration duration150 = Duration(milliseconds:150);

//  static Duration duration300 = Duration(milliseconds:300);
  static Duration duration = Duration(milliseconds: 350);

//  static Duration duration2 = Duration(seconds:2);
//  static Duration duration3 = Duration(seconds:3);
//  static Duration duration5 = Duration(seconds:5);

  static List<Color> randomColors = [
    Colors.pink,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.amber,
  ];

  static List<Currency> currencies = [
    Currency("0.028195 BTC", "\$196.82", 4.62, false, Icons.monetization_on_outlined, Colors.amber),
    Currency("3.428195 ETH", "\$779.26", 1.35, false, Icons.explore, Colors.blue),
    Currency("2.673617 LTC", "\$266.55", 2.85, true, Icons.euro, Colors.grey.shade800),
  ];

  static Future<void> delay() async {
    await Future.delayed(Duration(milliseconds: 350));
  }

  void startAnimations() async {
    await delay();

    setState(() => showFab = true);
    await delay();

    setState(() => showMoneyTile = true);
    await delay();

    await addHorizontalCircles();
    await delay();

    setState(() => showActive = true);
    await delay();

    setState(() => showCurrencyTile1 = true);
    await delay();

    setState(() => showCurrencyTile2 = true);
    await delay();

    setState(() => showNoAnalytics = true);
    await delay();

    setState(() => showCurrencyTile3 = true);
  }

  Future<void> addHorizontalCircles() async {
    horizontalCircleIconsLeft.add(Icons.south);
    horizontalCirclesKeyLeft.currentState?.insertItem(0, duration: duration);
    await delay();

    horizontalCircleIconsLeft.add(Icons.shortcut);
    horizontalCirclesKeyLeft.currentState?.insertItem(1, duration: duration);
    await delay();

    horizontalCircleIconsRight.add(Icons.cached);
    horizontalCirclesKeyRight.currentState?.insertItem(0, duration: duration);
    await delay();

    horizontalCircleIconsRight.add(Icons.north);
    horizontalCirclesKeyRight.currentState?.insertItem(1, duration: duration);
    await delay();

    showHorizontalCircleLabelsAndBackground = true;
    setState(() {});
  }

// 1) M̶a̶k̶e̶ t̶h̶e̶ m̶o̶n̶e̶y̶ t̶e̶x̶t̶ v̶i̶s̶i̶b̶l̶e̶ u̶s̶i̶n̶g̶ A̶n̶i̶m̶a̶t̶e̶d̶O̶p̶a̶c̶i̶t̶y̶
// 2) u̶s̶e̶ h̶o̶r̶i̶z̶o̶n̶t̶a̶l̶ a̶n̶i̶m̶a̶t̶e̶d̶ l̶i̶s̶t̶ a̶n̶d̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 1̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 2̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 0̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 3̶
// 3) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶o̶p̶a̶c̶i̶t̶y̶ t̶o̶ m̶a̶k̶e̶ a̶c̶t̶i̶v̶e̶ v̶i̶s̶i̶b̶l̶e̶
// 4) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶l̶i̶s̶t̶ t̶o̶ a̶d̶d̶ y̶e̶l̶l̶o̶w̶ c̶o̶i̶n̶ &̶ b̶l̶u̶e̶ c̶o̶i̶n̶
// 5) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶o̶p̶a̶c̶i̶t̶y̶ t̶o̶ m̶a̶k̶e̶ n̶o̶ s̶t̶a̶t̶i̶s̶t̶i̶c̶s̶ v̶i̶s̶i̶b̶l̶e̶
// 6) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶ l̶i̶s̶t̶ t̶o̶ a̶d̶d̶ g̶r̶e̶y̶ c̶o̶i̶n̶
// 7) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶ l̶i̶s̶t̶ t̶o̶ a̶d̶d̶ d̶o̶w̶n̶ u̶p̶ w̶i̶d̶g̶e̶t̶
// 8) b̶o̶t̶t̶o̶m̶ n̶a̶v̶i̶g̶a̶t̶i̶o̶n̶ b̶a̶r̶ w̶i̶t̶h̶ n̶o̶t̶c̶h̶e̶d̶ f̶a̶b̶

}
