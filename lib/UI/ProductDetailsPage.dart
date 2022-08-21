import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Dialogues/BuyDialogue.dart';
import 'package:fluttership/Models/ProductOption.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Option selectedMemoryOption = memoryOptions[0];
  Option selectedStorageOption = storageOptions[0];
  Option selectedEthernetOption = ethernetOptions[0];

  bool m1ChipSelected = true; //addtitional option we added

  Option selectedFinalCutProOption = finalCutProOptions[0];
  Option selectedLogicProOption = logicProOptions[0];

  bool addedToFavorite = false;

  // bool animate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      backgroundColor: Colors.black,
    );
  }

  Widget body() {
    return Column(
      children: [
        primaryListView(),
        buyTile(),
      ],
    );
  }

  Widget primaryListView() {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: [
          productImg(),
          titleTile(),
          m1ChipTile(),
          optionsBuilder(),
        ],
      ),
    );
  }

  Widget productImg() {
    double width = MediaQuery.of(context).size.width;
    double height = (width / 16) * 9;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(Urls.macMiniCover),
        ),
        color: Colors.black,
      ),
    );
  }

  Widget titleTile() {
    return ListTile(
      title: Txt(
        text: "Customise your Mac mini",
        textAlign: TextAlign.start,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(
        text: subtitle(),
        color: Colors.white70,
        textAlign: TextAlign.start,
      ),
    );
  }

  String subtitle() {
    String m1Chip = m1ChipSelected ? "with" : "without";
    return """Apple Mac Mini $m1Chip with 8-core CPU, 8-core GPU and 16-core Neural Engine ${selectedMemoryOption.title} ${selectedStorageOption.title} ${selectedEthernetOption.title}""";
  }

  Widget m1ChipTile() {
    return SwitchListTile(
      value: m1ChipSelected,
      title: Txt(
        text: "Include Apple M1 Chip",
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(
        text: "Learn more about the Apple M1 Chip",
        color: Colors.white70,
      ),
      onChanged: (z) {
        setState(() {
          m1ChipSelected = !m1ChipSelected;
        });
        // animateFn();
      },
    );
  }

  Widget optionsBuilder() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: productOptions.length,
        itemBuilder: (context, int index) {
          ProductOption productOption = productOptions[index];
          return ExpansionTile(
            initiallyExpanded: true,
            onExpansionChanged: (v) {
              // animateFn();
            },
            title: Txt(
              text: productOption.title,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Txt(
              text: productOption.description,
            ),
            trailing: Container(height: 1, width: 1),
            children: productOption.options.map((option) => optionTile(option)).toList(),
          );
        });
  }

  Widget optionTile(Option option) {
    bool selected = false;
    int index = 0;
    double selectedOptionsPrice = 0.0;
    switch (option.type) {
      case OptionType.Memory:
        selected = option == selectedMemoryOption;
        index = memoryOptions.indexOf(option);
        selectedOptionsPrice = selectedMemoryOption.price;
        break;
      case OptionType.Storage:
        selected = option == selectedStorageOption;
        index = storageOptions.indexOf(option);
        selectedOptionsPrice = selectedStorageOption.price;
        break;
      case OptionType.Ethernet:
        selected = option == selectedEthernetOption;
        index = ethernetOptions.indexOf(option);
        selectedOptionsPrice = selectedEthernetOption.price;
        break;
      case OptionType.FinalCutPro:
        selected = option == selectedFinalCutProOption;
        index = finalCutProOptions.indexOf(option);
        selectedOptionsPrice = selectedFinalCutProOption.price;
        break;
      case OptionType.LogicPro:
        selected = option == selectedLogicProOption;
        index = logicProOptions.indexOf(option);
        selectedOptionsPrice = selectedLogicProOption.price;
        break;
    }

    bool isDefault = index == 0;

    String addOrRemove = isDefault ? "-" : "+";
    double price = isDefault ? selectedOptionsPrice : option.price;
    String subtitle =
        "$addOrRemove ₹${price.toInt()}"; //To use $, type /n before $ Eg: => "/n$2,999",

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: duration,
        decoration: BoxDecoration(
          color: selected ? Colors.white10 : Colors.black,
          border: Border.all(
            color: selected ? Colorz.timerBlue : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Txt(
            text: option.title,
            color: Colors.white,
          ),
          subtitle: selected
              ? null
              : Txt(
                  text: subtitle,
                  color: Colors.white70,
                ),
          trailing: (selected == true && isDefault == false)
              ? Icon(Icons.check_circle, color: Colorz.timerBlue)
              : null,
          onTap: () {
            switch (option.type) {
              case OptionType.Memory:
                selectedMemoryOption = option;
                break;
              case OptionType.Storage:
                selectedStorageOption = option;
                break;
              case OptionType.Ethernet:
                selectedEthernetOption = option;
                break;
              case OptionType.FinalCutPro:
                selectedFinalCutProOption = option;
                break;
              case OptionType.LogicPro:
                selectedLogicProOption = option;
                break;
            }
            setState(() {
              // animateFn();
            });
          },
        ),
      ),
    );
  }

  Widget buyTile() {
    double totalPrice = selectedMemoryOption.price +
        selectedStorageOption.price +
        selectedEthernetOption.price +
        selectedFinalCutProOption.price +
        selectedLogicProOption.price;

    double emiCost = totalPrice / 8.49;

    return AnimatedContainer(
      duration: duration,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        // leading: IconButton(
        //   icon: Icon(addedToFavorite? Icons.favorite : Icons.favorite_outline,
        //   color: Colorz.timerBlue,
        //   ),
        //   onPressed: (){
        //     setState(()=>addedToFavorite = !addedToFavorite);
        //animateFn();
        //   }
        // ),
        title: Txt(
          text: "₹${totalPrice.toInt()}",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Txt(
          text: "From ₹${emiCost.toInt()}/month with EMI",
          color: Colors.white70,
        ),
        trailing: buyButton(),
        // onTap: animateFn,
      ),
    );
  }

  Widget buyButton() {
    return InkWell(
      onTap: buyFn,
      child: Container(
        height: 70,
        width: 100,
        child: Txt(
          text: "BUY",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colorz.timerBlue,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void buyFn() async {
    showDialog(
        context: context,
        builder: (context) {
          return BuyDialgoue();
        });
  }

  static List<ProductOption> productOptions = [
    ProductOption("Memory", "How much memory is right for you?", memoryOptions),
    ProductOption("Storage", "How much storage is right for you?", storageOptions),
    ProductOption("Ethernet", "Which Ethernet speed is right for you?", ethernetOptions),
    ProductOption("Final Cut Pro", "Learn more", finalCutProOptions),
    ProductOption("Logic Pro", "Learn more", logicProOptions),
  ];

  static List<Option> memoryOptions = [
    Option("8GB Unified Memory", 10000, OptionType.Memory),
    Option("16GB Unified Memory", 20000, OptionType.Memory),
  ];

  static List<Option> storageOptions = [
    Option("256GB SSD Storage", 10000, OptionType.Storage),
    Option("512GB SSD Storage", 20000, OptionType.Storage),
    Option("1TB SSD Storage", 40000, OptionType.Storage),
    Option("2TB SSD Storage", 80000, OptionType.Storage),
  ];

  static List<Option> ethernetOptions = [
    Option("Gigabit Ethernet", 5000, OptionType.Ethernet),
    Option("10 Gigabit Ethernet", 10000, OptionType.Ethernet),
  ];

  static List<Option> finalCutProOptions = [
    Option("None", 0, OptionType.FinalCutPro),
    Option("Final Cut Pro", 24900, OptionType.FinalCutPro),
  ];

  static List<Option> logicProOptions = [
    Option("None", 0, OptionType.LogicPro),
    Option("Logic Pro", 15500, OptionType.LogicPro),
  ];

  static const Duration duration = Duration(milliseconds: 350);
}
