import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;

  const MyTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        indicatorColor: Colors.white,
        dividerHeight: 0,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white, fontSize: 17),
        tabs: tabs.map((tab) => Container(
          constraints: const BoxConstraints(minWidth: 100),
          child: Tab(
            text: tab.text,
          ),
        )).toList());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
