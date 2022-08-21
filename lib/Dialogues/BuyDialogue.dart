import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class BuyDialgoue extends StatefulWidget {
  const BuyDialgoue({Key? key}) : super(key: key);

  @override
  _BuyDialgoueState createState() => _BuyDialgoueState();
}

class _BuyDialgoueState extends State<BuyDialgoue> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(20),
        child: Material(
          borderRadius: BorderRadius.circular(18),
          color: Colorz.complexDrawerBlack,
          elevation: 25,
          shadowColor: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Icon(Icons.local_shipping, color: Colorz.compexDrawerCanvasColor, size: 100),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Txt(
                      text:
                          "Are you sure want to confirm the purchase the product with selected configuration options?",
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Txt(
                      text: "You can cancel this before shipping.",
                      color: Colors.white70,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    List<String> options = [
      "Cancel",
      "Confirm",
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map((option) {
        bool isConfirmOption = options.indexOf(option) == 1;
        return Button(
          text: option,
          textColor: Colors.white,
          width: MediaQuery.of(context).size.width / 2.75,
          buttonColor: isConfirmOption ? Colorz.timerBlue : Colorz.complexDrawerBlueGrey,
          processingText: isConfirmOption? "Confirming...":"Cancelling...",
          onPressed: isConfirmOption ? confirmFn : closeFn,
        );
      }).toList(),
    );
  }

  void closeFn() {
    Navigator.of(context).pop();
  }

  void confirmFn() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => isLoading = true);
    Navigator.of(context).pop();
  }
}
