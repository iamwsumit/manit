import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<StatefulWidget> createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
          title: const Text('Announcement'),
        ),
        body: const SingleChildScrollView(
            child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 35, horizontal: 30),
                    child: FlutterLogo(size: 100)))));
  }
}