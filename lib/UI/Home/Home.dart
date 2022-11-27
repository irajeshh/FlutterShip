import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/Clone.dart';
import 'package:fluttership/UI/Home/Mobile.dart';
import 'package:fluttership/UI/Home/Web.dart';
import 'package:fluttership/UI/Pages/Account.dart';
import 'package:fluttership/UI/Pages/AssemblingAnalyticsPage.dart';
import 'package:fluttership/UI/Pages/ButtonExample.dart';
import 'package:fluttership/UI/Pages/CustomStepper.dart';
import 'package:fluttership/UI/Pages/DoubleCardExample.dart';
import 'package:fluttership/UI/Pages/ExpandedBottomNav.dart';
import 'package:fluttership/UI/Pages/ExpandileExample.dart';
import 'package:fluttership/UI/Pages/GoogleSearchPage.dart';
import 'package:fluttership/UI/Pages/ImgExample.dart';
import 'package:fluttership/UI/Pages/InkkExample.dart';
import 'package:fluttership/UI/Pages/InterLacedDashBoard.dart';
import 'package:fluttership/UI/Pages/DribbbleBalExample.dart';
import 'package:fluttership/UI/Pages/ProductDetailsPage.dart';
import 'package:fluttership/UI/Pages/RichCalculator.dart';
import 'package:fluttership/UI/Pages/SendMoneyPage.dart';
import 'package:fluttership/UI/Pages/Tesla/Page.dart';
import 'package:fluttership/UI/Pages/TimerDrawerPage.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Pages/ComplexDrawerPage.dart';
import '../Pages/CurrenciesPage.dart';
import '../Pages/ScrollerSamplePage.dart';

///Home page which dynamically provides different home for different devices
class HomePage extends StatefulWidget {
  ///Constructor
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ResponsiveBuilder(
        builder: (BuildContext builder, SizingInformation screen) {
          final bool isWeb =
              screen.localWidgetSize.height > 400 && screen.localWidgetSize.width > 600;
          if (isWeb) {
            return WebHomePage(clones: clones);
          } else {
            return MobileHomePage(
              clones: clones,
            );
          }
        },
      ),
    );
  }

  static List<Clone> clones = [
    Clone(
      icon: Icons.car_rental,
      color: Colorz.complexDrawerBlack,
      title: 'Tesla car control',
      description: 'Remote application model to control a tesla car for educational purpose only',
      page: TeslaCarAppPage(),
    ),
    Clone(
      title: 'Expandile example',
      description: 'To use expadile widget',
      icon: Icons.expand_circle_down_outlined,
      color: Colorz.iphone12Purple,
      page: ExpandileExamplePage(),
    ),
    Clone(
      title: "Product Details",
      description: "An Imaginary UI of Apple Macbook Customization Page",
      icon: Icons.computer,
      color: Colors.red,
      page: ProductDetailsPage(),
    ),
    Clone(
      title: "Interlaced Dashboard",
      description: "Designing a mixed account dashboard",
      icon: Icons.dashboard_outlined,
      color: Colors.purple,
      page: InterLacedDashBoard(),
    ),
    Clone(
      title: "Assembling Analytics",
      description: "Analytics page with auto assembling animated widgets",
      icon: Icons.apps,
      color: Colors.blue,
      page: AssemblingAnalyticsPage(),
    ),
    Clone(
      title: "Complex Drawer",
      description: "Designing a complex drawer menu",
      icon: Icons.menu,
      color: Colors.black,
      page: ComplexDrawerPage(),
    ),
    Clone(
      title: "Google Search Clone",
      description: "Cloing a google search results page",
      icon: Icons.search,
      color: Colors.amber,
      page: GoogleSearchPage(),
    ),
    Clone(
      title: "Send Money",
      description: "Money transfer screen design from dribbble.com",
      icon: Icons.dialpad,
      color: Colorz.sendMoneyBlue,
      page: SendMoneyPage(),
    ),
    Clone(
      title: "Currency page",
      description: "Crypto currency coins app design dribbble.com",
      icon: Icons.monetization_on,
      color: Colors.green,
      page: CurrenciesPage(),
    ),
    Clone(
      title: "Timer Drawer",
      description: "Simple clean drawer design from dribbble.com",
      icon: Icons.calendar_today,
      color: Colorz.timerBlue,
      page: TimerDrawerPage(),
    ),
    Clone(
      title: "Account Page",
      description: "Colorful & BW Account Dashboard",
      icon: Icons.person,
      color: Colors.pink,
      page: AccountPage(),
    ),
    Clone(
      title: "Scroller Sample",
      description: "Example use case of scroller widget",
      icon: Icons.list,
      color: Colors.blue,
      page: ScrollerSamplePage(),
    ),
    Clone(
      title: "Expanded Bottom Navigation Bar",
      description: "A custom bottom navigation bar with additional menus",
      icon: Icons.dns,
      color: Colorz.complexDrawerBlack,
      page: ExpandedBottomNavigationBarPage(),
    ),
    Clone(
      title: "Rich Calculator",
      description: "A Non functioning calculator ui",
      icon: Icons.calculate,
      color: Colors.black,
      page: RichCalculatorPage(),
    ),
    Clone(
      title: "Img",
      description: "Example use case of Img widget",
      icon: Icons.photo,
      color: Colors.green,
      page: ImgExample(),
    ),
    Clone(
      title: "Buttons",
      description: "Example use case of Button Widget",
      icon: Icons.touch_app,
      color: Colors.deepPurple,
      page: ButtonExample(),
    ),
    Clone(
      title: "Inkk",
      description: "Example use case of Inkk Widget",
      icon: Icons.touch_app,
      color: Colors.blue,
      page: InkkExample(),
    ),
    Clone(
      title: "Custom Stepper",
      description: "Example use case of custom stepper widget design",
      icon: Icons.format_list_numbered,
      color: Colors.green,
      page: StepperExample(),
    ),
    Clone(
      title: "Dribbble Ball",
      description: "Example use case of dribbble ball type of loading widgets",
      icon: Icons.sports_basketball,
      color: Colors.pink,
      page: DribbbleBallExamplePage(),
    ),
    Clone(
      title: 'Double card example page',
      description: 'To use the double card widget',
      icon: Icons.layers,
      color: Colorz.doubleCardBlue,
      page: DoubleCardExample(),
    ),
  ];
}
