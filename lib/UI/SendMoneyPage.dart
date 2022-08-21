import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({Key? key}) : super(key: key);

  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  List numberAsList = [];

  String money = '20';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back)),
      elevation: 0,
      title: Txt(text: "Send money"),
      backgroundColor: Colors.grey.shade900,
    );
  }

  Widget body() {
    return Column(
      children: [
        userTile(),
        moneyWidget(),
        keypadWidget(),
        button(),
      ],
    );
  }

  Widget userTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(Urls.avatar2),
      ),
      title: Txt(
        text: "Jane Foster",
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subtitle: cardWithNumber(),
      trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18), onPressed: () {}),
    );
  }

  Widget cardWithNumber() {
    return Row(
      children: [
        Icon(Icons.credit_card, color: Colors.grey, size: 18),
        Txt(
            text: " **** 5064",
            //  text: "98765432105064".replaceRange(0,10," **** "),
            color: Colors.grey),
      ],
    );
    // return RichText( this alignment is not satisfying
    //   text: TextSpan(
    //     children: [
    //       WidgetSpan(
    //         child: Icon(Icons.credit_card, color: Colors.grey),
    //       ),
    //       TextSpan(
    //         text: "98765432105064".replaceRange(0,10,"****"),
    //       ),
    //     ]
    //   ),
    // );
  }

  Widget moneyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: RichText(
//$
          text: TextSpan(
        text: '\$',
        style: TextStyle(
          fontSize: 60,
          color: Colors.grey.withOpacity(0.5),
          fontWeight: FontWeight.w300,
        ),
        children: [
//20
          TextSpan(
            text: money,
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
//.0
          if (money != '')
            TextSpan(
                text: '.0',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.w300,
                )),
        ],
      )),
    );
  }

  Widget keypadWidget() {
    return Flexible(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: numbers.length,
        itemBuilder: (BuildContext context, int index) {
          int number = numbers[index];
          if (index == 9) return Container(height: 0, width: 0);
          return InkWell(
            borderRadius: BorderRadius.circular(360),
            onTap: () {
              if (index == 11) {
                try {
                  setState(() => money = money.replaceRange(money.length - 1, money.length, ''));
                } catch (e) {
                  print("Error removing $e");
                }
              } else {
                setState(() => money = '$money$number');
              }
            },
            child: Container(
              child: index == 11
                  ? Icon(Icons.backspace, color: Colors.grey)
                  : Txt(
                      text: number,
                      color: Colors.white,
                    ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Container(
        height: 55,
        width: double.maxFinite,
        alignment: Alignment.center,
        child: Txt(
          text: "Transfer to Jane",
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: Colorz.sendMoneyBlue,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, -1, 0, -1];
}
