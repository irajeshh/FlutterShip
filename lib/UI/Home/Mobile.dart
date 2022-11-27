import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
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
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(
        text: 'Fluttershipp',
      ),
      backgroundColor: Colorz.primaryColor,
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
    return Expanded(
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: _clones.length,
        itemBuilder: (BuildContext context, int index) {
          final Clone clone = _clones[index];
          return cloneTile(clone);
        },
      ),
    );
  }

  Widget cloneTile(Clone clone){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12,),
      child: Card(
        elevation: 6,
        child: ListTile(
                leading: IconButton(
                    icon: Icon(
                  clone.icon,
                  color: clone.color,
                )),
                title: Txt(
                  text: clone.title,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: Txt(
                  text: clone.description,
                ),
                onTap: () {
                  Widgets.push(clone.page, context);
                },
              ),
      ),
    );
  }

  void clearSearch() {
    searchController.clear();
    query = '';
    FocusScope.of(context).unfocus();
  }
}
