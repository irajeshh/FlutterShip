import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class RichCalculatorPage extends StatefulWidget {
  const RichCalculatorPage({Key? key}) : super(key: key);

  @override
  _RichCalculatorPageState createState() => _RichCalculatorPageState();
}

class _RichCalculatorPageState extends State<RichCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorz.richCalculatorCanvas,
      body: body(),
    );
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        displaySpace(),
        topRow(),
        bottomRow(),
      ],
    );
  }

  Widget displaySpace() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Txt(
            text: "256.6+9.5",
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          Txt(
            text: "269.1",
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget topRow() {
    List symbols = [
      "c",
      "÷",
      "x",
      Icons.backspace_outlined,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: symbols.map((symbol) {
        int index = symbols.indexOf(symbol);
        BorderRadius? borderRadius;

        if (index == 0) borderRadius = BorderRadius.only(topLeft: Radius.circular(18));
        if (index == 3) borderRadius = BorderRadius.only(topRight: Radius.circular(18));

        bool isIcon = symbol is IconData;
        Color color = symbol == 'c' ? Colors.white : Colors.amber;
        double fontSize = symbol == 'c' ? 20 : 28;
        double width = MediaQuery.of(context).size.width / symbols.length;
        width = width - 1;

        return Container(
          child: isIcon
              ? Icon(symbol, color: color)
              : Txt(
                  fontSize: fontSize,
                  text: symbol,
                  color: color,
                ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(horizontal: (index == 1 || index == 2) ? 1 : 0),
          height: width,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colorz.richCalculatorOutterButtonColor,
            borderRadius: borderRadius,
          ),
        );
      }).toList(),
    );
  }

  Widget bottomRow() {
    double totalWidth = MediaQuery.of(context).size.width;
    double width = totalWidth / 4.35;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // innerGrid(),
        coulmnBuilder(width),
        rightColumn(width),
      ],
    );
  }

  Widget coulmnBuilder(double buttonWidth) {
    List<List<String>> numbers = [
      ['7', '8', '9'],
      ['4', '5', '6'],
      ['1', '2', '3'],
      ['%', '0', '.'],
    ];

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: numbers.map((_numbers) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _numbers.map((number) {
              return Container(
                height: buttonWidth - 1,
                width: buttonWidth + 6,
                margin: EdgeInsets.all(1),
                child: Txt(
                  text: number,
                  fontSize: 22,
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colorz.richCalculatorInnerButtonColor,
                ),
              );
            }).toList(),
          );
        }).toList());
  }

  Widget rightColumn(double buttonWidth) {
    List symbols = [
      Icons.remove,
      Icons.add,
      "=",
    ];
    return Column(
      children: symbols.map((symbol) {
        // int index = symbols.indexOf(symbol);

        bool isEqual = symbol == '=';

        Color color = isEqual ? Colors.white : Colors.amber;
        double fontSize = 28;
        double width = buttonWidth;

        return Container(
          child: isEqual
              ? Txt(
                  fontSize: fontSize,
                  text: symbol,
                  color: color,
                )
              : Icon(symbol, color: color),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 1),
          height: width * (isEqual ? 2 : 1),
          width: width + 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isEqual
                ? Colorz.richCalculatorYellowButtonColor
                : Colorz.richCalculatorOutterButtonColor,
          ),
        );
      }).toList(),
    );
  }

  /*
    d̶i̶s̶p̶l̶a̶y̶S̶p̶a̶c̶e̶
      ∟t̶y̶p̶e̶d̶P̶r̶e̶v̶i̶e̶w̶
      ∟o̶u̶t̶p̶u̶t̶

    t̶o̶p̶R̶o̶w̶
    
    bottomRow
    ∟r̶i̶g̶h̶t̶C̶o̶l̶u̶m̶n̶
    ∟innerGrid
  */
}
