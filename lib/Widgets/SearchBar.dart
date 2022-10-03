import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

///An animated search bar which will shrink and expand itself on clicking
class SearchBar extends StatefulWidget {
  ///Function to be executed when something is typed
  final Function(String z) onChanged;

  ///Constructor
  SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  ///The variable to decide if the search field is to be shown or not
  bool showSearchField = false;

  ///Color of the search button
  static final Color searchButtonColor = Colorz.accountPurple;

  ///Color of the clear button
  static final Color clearButtonColor = Colors.black;

  Color get primaryColor => Colorz.accountPurple;

  Color get textColor => Colors.white;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: showSearchField ? Alignment.center : Alignment.centerRight,
      duration: Widgets.duration1Sec,
      padding: EdgeInsets.only(
        top: showSearchField ? 60 : 50,
        bottom: showSearchField ? 30 : 20,
        left: showSearchField ? 12 : 8,
        right: showSearchField ? 12 : 12,
      ),
      child: Material(
        elevation: showSearchField ? 12 : 4,
        shadowColor: primaryColor,
        borderRadius: BorderRadius.circular(360),
        child: AnimatedContainer(
            duration: Widgets.duration1Sec,
            decoration: BoxDecoration(
              color: showSearchField ? primaryColor : searchButtonColor,
              ////[Not satisfied]
              // boxShadow: [
              //   if(showSearchField) BoxShadow(
              //     color: searchButtonColor,
              //     blurRadius: 1.1,
              //     spreadRadius: 1.5,
              //   )
              // ],
              ///If to show search box, we will use a little curved border,
              ///otherwise the whole box will become a [circle]
              borderRadius: BorderRadius.circular(360),
            ),

            ///If [true], show [searchField()] otherwise simply show the [icon]
            child: CrossFade(
              show: showSearchField,
              child: searchBar(),
              hiddenChild: searchButton(),
            )),
      ),
    );
  }

  ///The [TextField & ClearButton] widgets will be placed in this row
  Widget searchBar() {
    ///[Not fit]
    ///This setup is messing with the design we thought
    // return Container(
    //   child: TextField(
    //     decoration: InputDecoration(
    //       hintText: 'Search',
    //       suffixIcon: clearButton(),
    //     ),
    //   ),
    // );
    ///[Not fit]
    // return ListTile(
    //   contentPadding: EdgeInsets.only(left: 18),
    //   title: TextField(
    //     decoration: InputDecoration(
    //       hintText: 'Search...',
    //       border: InputBorder.none,
    //     ),
    //   ),
    //   trailing: clearButton(),
    // );
    ///This one works fine
    return Row(
      children: [
        if (showSearchField)
          opacity(
            duration: Duration(seconds: 5),
            child: searchButton(enabled: false),
          ),

        ///For beauty purpose only, this is non functional
        searchField(),
        clearButton(),
      ],
    );
  }

  Widget searchField() {
    return Expanded(
      child: opacity(
        child: TextField(
          ///Helps to focus immediately
          autofocus: true,
          onChanged: widget.onChanged,
          style: textStyle(),
          cursorColor: textColor,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: textStyle(),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  TextStyle textStyle() => TextStyle(
        color: textColor,
      );

  ///Search Button
  ///By default, this is functional, but if you need to disable it,
  ///pass the value as [false]
  Widget searchButton({bool enabled = true}) {
    return IconButton(
      tooltip: enabled ? 'Search' : null,
      icon: Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: enabled == false
          ? null
          : () {
              if (mounted) setState(() => showSearchField = true);
            },
    );
  }

  ///Clear Button to hide the search bar
  Widget clearButton() {
    return opacity(
      duration: Duration(seconds: 4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: clearButtonColor,
          borderRadius: BorderRadius.circular(360),
        ),
        child: IconButton(
          tooltip: 'Clear',
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            if (mounted) setState(() => showSearchField = false);

            ///This will clear up the query
            widget.onChanged('');

            ///If keyboard is open, this will close it automaitcally
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  ///A widget which shows the given child in a specific time period with optional duration
  Widget opacity({required Widget child, Duration? duration}) {
    return AnimatedOpacity(
      opacity: showSearchField ? 1 : 0,
      duration: duration ?? Widgets.duration2Sec,
      child: child,
    );
  }
}
