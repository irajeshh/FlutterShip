import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';
// import 'package:fluttership/Dialogues/BuyDialogue.dart';

class ExpandileExamplePage extends StatefulWidget {
  const ExpandileExamplePage({Key? key}) : super(key: key);

  @override
  State<ExpandileExamplePage> createState() => _ExpandileExamplePageState();
}

class _ExpandileExamplePageState extends State<ExpandileExamplePage> {
  ///Primary color for this tutorial
  static final Color primaryColor = Colorz.interlacedChatPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  ///AppBar of the scaffold
  AppBar appBar() {
    return AppBar(
      title: Txt(text: 'Expandile example'),
      elevation: 8,
      backgroundColor: Widgets.darkenColor(primaryColor, 0.6),
    );
  }

  ///Body of the scaffold
  Widget body() {
    return ListView(
      children: <Widget>[
        // expandile1(),
        expandile2(),
      ],
    );
  }

  ///Example 1: For developement
  Widget expandile1() {
    return Expandile(
      leading: Icons.alarm,
      primaryColor: primaryColor,
      title: 'Sample title',
      description: 'This is a sample description line to test the widget',
      children: [
        Txt(text: "This is a hidden information, which can be only viewed at the time of, expanded")
      ],
    );
  }

  ///Example 2: For customization demo
  ///It's upto you for more customzations
  Widget expandile2() {
    return Expandile(
      primaryColor: primaryColor,
      leading: _leading(),
      title: 'Buy Iphone 12 mini purple',
      description: 'Click here to see more information',
      maxDescriptionLines: 1,
      children: <Widget>[
        imgWidget(),
        timeText(),
        availableText(),
      ],
      footer: actionButtons(),
    );
  }

  Widget _leading() {
    return CircleAvatar(
      child: Icon(
        Icons.shopping_bag,
        color: Colors.white,
      ),
      backgroundColor: primaryColor,
    );
  }

  ///Children1 of the widget
  Widget imgWidget() {
    final String imgUrl = "https://spectrum.ieee.org/media-library/image.jpg?id=27044748";
    return Img(
      imgUrl: imgUrl,
      outterPadding: 8,

      ///Just making the image as 16:9 ratio
      height: (Widgets.mwidth(context) / 16) * 9,
      width: Widgets.mwidth(context),
    );
  }

  ///Children2 of the widget
  Widget timeText() {
    int createdAt = DateTime.now().millisecondsSinceEpoch - 10000;
    return detailsCard('Last time a purchase was made at ${Widgets.toDateTime(createdAt)}');
  }

  Widget availableText() {
    return detailsCard('Currently the phone is available on retail and online shops!');
  }

  ///A reusable txt widget, which is to be used inside [Children] widgets
  Widget detailsCard(String text) {
    return Inkk(
      spalshColor: primaryColor,
      onTap: openDetailsFn,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Txt(
          text: text.replaceAll('\n', ' '),
          maxLines: 3,
          color: Widgets.subtitleColor(context),
        ),
      ),
    );
  }

  ///Footer widgets
  ///Some list of buttons which will not hide itself
  Widget actionButtons() {
    return Row(
      children: <Widget>[
        shareButton(),
        buyButton(),
        moreButton(),
      ],
    );
  }

  Widget shareButton() {
    return Expanded(
        child: Button(
      text: 'Share',
      processingText: 'Sharing...',
      textColor: primaryColor,
      buttonColor: primaryColor.withOpacity(0.1),
      onPressed: shareFn,
    ));
  }

  Widget buyButton() {
    return Expanded(
      child: Button(
        text: 'Buy now',
        processingText: 'Buying...',
        buttonColor: primaryColor,
        onPressed: buyFn,
      ),
    );
  }

  Widget moreButton() {
    return IconButton(
      tooltip: 'More',
      onPressed: moreFn,
      icon: Icon(
        Icons.more_vert,
        color: primaryColor,
      ),
    );
  }

  void openDetailsFn() {
    ///To open the details page of the content
  }

  Future<void> shareFn() async {
    await Widgets.wait(3000);
  }

  Future<void> buyFn() async {
    await Widgets.wait(5000);
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return BuyDialgoue();
    //     });
  }

  Future<void> moreFn() async{
    debugPrint("More button is pressed!");
  }
}
