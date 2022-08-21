import 'package:flutter/material.dart';
import 'package:fluttership/Models/CustomStep.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class StepperExample extends StatefulWidget {
  const StepperExample({Key? key}) : super(key: key);

  @override
  _StepperExampleState createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      backgroundColor: Colors.white,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(
        text: "Order details",
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }

  Widget body() {
    return CustomStepper(
      steps: steps,
    );
  }

  static List<CustomStep> steps = [
    CustomStep(DateTime(2021, 8, 9, 9, 30).millisecondsSinceEpoch, "Order Placed",
        "Your order #212423 was placed for delivery"),
    CustomStep(DateTime(2021, 8, 9, 9, 35).millisecondsSinceEpoch, "Pending",
        "Your order is pending for confirmation. Wil confirmed within 5 minutes"),
    CustomStep(DateTime(2021, 8, 9, 9, 55).millisecondsSinceEpoch, "Confirmed",
        "Your order is confirmed. Will deliver soon within 20 minutes."),
    CustomStep(0, "Processing", "Your product is processing to deliver you on time."),
    CustomStep(0, "Delivered", "Product deliver to you and marked as delivered by customer."),
  ];
}

class CustomStepper extends StatefulWidget {
  final List<CustomStep> steps;
  const CustomStepper({Key? key, required this.steps}) : super(key: key);

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  double fullWidth(context) => MediaQuery.of(context).size.width;
  double timeWidth(context) => fullWidth(context) / 5;
  double get dividerWidth => 60;
  double tileWidth(context) => fullWidth(context) - timeWidth(context) - 60;
  double get height => 100;

  @override
  Widget build(BuildContext context) {
    return method2();
  }

  Widget method1() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          timeWidgets(),
          dividers(),
          tiles(),
        ],
      ),
    );
  }

  Widget method2() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: widget.steps.length,
        itemBuilder: (context, int index) {
          CustomStep step = widget.steps[index];
          String time = step.createdAt == 0 ? "" : Widgets.toTime(step.createdAt);
          bool isLast = index == widget.steps.length - 1;
          bool inComplete = widget.steps[index].createdAt == 0;
          // return timeWidget(time);
          return Row(
            children: [
              Container(
                child: timeWidget(time),
                width: timeWidth(context),
              ),
              Container(
                child: dividerWidget(isLast, inComplete),
                width: dividerWidth,
              ),
              Expanded(
                child: tileWidget(step),
              ),
            ],
          );
        });
  }

  Widget timeWidgets() {
    return Container(
      child: ListView.builder(
          itemCount: widget.steps.length,
          itemBuilder: (context, int index) {
            CustomStep step = widget.steps[index];
            String time = step.createdAt == 0 ? "" : Widgets.toTime(step.createdAt);
            return timeWidget(time);
          }),
    );
  }

  Widget timeWidget(String time) {
    return Container(
      height: height,
      alignment: Alignment.topCenter,
      child: Txt(
        text: time,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget dividers() {
    return Container(
      alignment: Alignment.center,
      width: dividerWidth,
      child: ListView.builder(
          itemCount: widget.steps.length,
          itemBuilder: (context, int index) {
            bool isLast = index == widget.steps.length - 1;
            bool inComplete = widget.steps[index].createdAt == 0;
            return dividerWidget(isLast, inComplete);
          }),
    );
  }

  Widget dividerWidget(bool isLast, bool inComplete) {
    return Container(
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          if (isLast == false)
            Container(
              width: 1,
              color: Colors.grey.shade300,
            ),
          Container(
            child: Container(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.check, color: Colors.white, size: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: inComplete ? Colors.grey : Colors.white,
                  ),
                  color: inComplete ? Colors.white : Colors.green,
                  shape: BoxShape.circle,
                )),
            padding: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget tiles() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: tileWidth(context),
        child: ListView.builder(
            itemCount: widget.steps.length,
            itemBuilder: (context, int index) {
              CustomStep step = widget.steps[index];
              return tileWidget(step);
            }),
      ),
    );
  }

  Widget tileWidget(CustomStep step) {
    return Container(
      height: height,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            text: step.title,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Txt(
              text: step.description,
              maxLines: 3,
              color: Theme.of(context).textTheme.caption?.color,
            ),
          ),
        ],
      ),
    );
  }
}
