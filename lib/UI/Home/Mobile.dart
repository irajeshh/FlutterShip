import 'package:flutter/material.dart';
import 'package:fluttership/Models/Clone.dart';

import '../../Widgets/SearchBar.dart';
import '../../Widgets/Widgets.dart';

class MobileHomePage extends StatefulWidget {
  final List<Clone> clones;
  const MobileHomePage({Key? key, required this.clones}) : super(key: key);

  @override
  _MobileHomePageState createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  final TextEditingController searchController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        searchField(),
        clonesResult(),
      ],
    );
  }

  Widget searchField() {
    return SearchBar(
      onChanged: (z) => setState(() => query = z.toLowerCase()),
    );
  }

  Widget clonesResult() {
    List<Clone> _clones = widget.clones.where((clone) {
      return clone.title.toString().toLowerCase().contains(query) ||
          clone.title.toString().toLowerCase().contains(query);
    }).toList();
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: false,
        itemCount: _clones.length,
        itemBuilder: (BuildContext context, int index) {
          Clone clone = _clones[index];
          return ColorTile(
              icon: clone.icon,
              color: clone.color,
              title: clone.title,
              subtitle: clone.description,
              onTap: () {
                Widgets.push(clone.page, context);
              });
        },
      ),
    );
  }

  void clearSearch() {
    searchController.clear();
    query = '';
    FocusScope.of(context).unfocus();
  }
}
