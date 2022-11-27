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
  bool useGridView = true;

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
      centerTitle: false,
      backgroundColor: Colorz.primaryColor,
    );
  }

  Widget body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              styleButton(),
              searchField(),
            ],
          ),
        ),
        clonesResult(),
      ],
    );
  }

  Widget searchField() {
    return Expanded(
      child: SearchBar(
        onChanged: (z) => setState(() => query = z.toLowerCase()),
      ),
    );
  }

  Widget clonesResult() {
    return Expanded(
      child: CrossFade(
        useCenter: false,
        hiddenChild: gridViewBuilder(),
        show: useGridView,
        child: listViewBuilder(),
      ),
    );
  }

  Widget listViewBuilder() {
    return ListView.builder(
      itemCount: _clones.length,
      itemBuilder: (BuildContext context, int index) {
        final Clone clone = _clones[index];
        return cloneTile(clone);
      },
    );
  }

  Widget gridViewBuilder() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      padding: EdgeInsets.all(12),
      itemCount: _clones.length,
      itemBuilder: (BuildContext context, int index) {
        final Clone clone = _clones[index];
        return cloneCard(clone);
      },
    );
  }

  Widget cloneTile(Clone clone) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
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

  Widget cloneCard(Clone clone) {
    return Card(
      elevation: 8,
      shadowColor: clone.color.withAlpha(100),
      child: Inkk(
        onTap: () {
          Widgets.push(clone.page, context);
        },
        spalshColor: clone.color,
        child: Container(
          width: double.maxFinite,
          color: clone.color.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                clone.icon,
                color: clone.color,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Txt(
                  text: clone.title,
                  maxLines: 1,
                  fontSize: 18,
                  color: clone.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget styleButton() {
    return IconButton(
      icon: CrossFade(
        show: useGridView,
        hiddenChild: const Icon(
          Icons.grid_view_rounded,
          color: Colorz.primaryColor,
        ),
        child: const RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.view_week,
            color: Colorz.primaryColor,
          ),
        ),
      ),
      tooltip: !useGridView ? 'Change to grid view' : 'Change to list view',
      onPressed: () {
        if (mounted) setState(() => useGridView = !useGridView);
      },
    );
  }

  List<Clone> get _clones => widget.clones.where((clone) {
        return clone.title.toString().toLowerCase().contains(query) ||
            clone.title.toString().toLowerCase().contains(query);
      }).toList();

  void clearSearch() {
    searchController.clear();
    query = '';
    FocusScope.of(context).unfocus();
  }
}
