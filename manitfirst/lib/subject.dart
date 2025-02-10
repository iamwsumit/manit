import 'package:flutter/material.dart';

import 'package:manitfirst/utils/theme.dart';
import 'package:manitfirst/utils/utility.dart';

import 'comps/tabbar.dart';

class Subject extends StatefulWidget {
  const Subject({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<Subject> createState() => SubjectState();
}

class SubjectState extends State<Subject> {
  late Utils utils;
  bool isLoading = true;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    utils = Utils(context: context);
    data = widget.data;
    final Map<String, dynamic> sData = data['data'] ?? {};
    if (sData.keys.isEmpty) {
      Future.microtask(() {
        Utils.showToast(msg: 'Invalid Subject or data not found');
        Navigator.pop(context);
      });
      return;
    }
    for (final e in sData.entries) {
      tabs.add(Tab(text: e.key));
      children.add(Column(
        children: [const CircularProgressIndicator()],
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  final List<Tab> tabs = [];
  final List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator(color: MyTheme.primary))
        : DefaultTabController(
            length: tabs.length,
            child: Scaffold(
                appBar: AppBar(
                  bottom: MyTabBar(
                    tabs: tabs,
                  ),
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context)),
                  title: Text(data['name']),
                ),
                resizeToAvoidBottomInset: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: TabBarView(
                  children: children,
                )));
  }
}
