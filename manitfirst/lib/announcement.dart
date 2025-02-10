import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manitfirst/utils/data.dart';
import 'package:manitfirst/utils/theme.dart';
import 'package:manitfirst/utils/utility.dart';
import 'dart:convert';

import 'comps/announcement_card.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<StatefulWidget> createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement> {
  List<dynamic> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAnnouncements();
  }

  Future<void> fetchAnnouncements() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/iamwsumit/manit/refs/heads/main/announcement.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          notifications = data['notifications'] ?? [];
          isLoading = false;
        });
      } else {
        closeActivity();
      }
    } catch (e) {
      closeActivity();
    }
  }

  void closeActivity() {
    Utils.showToast(msg: 'Failed to load announcements');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Announcements'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: MyTheme.primary,
              ))
            : LayoutBuilder(
                builder: (context, constraints) {
                  double maxW = constraints.maxWidth;
                  int crossAxisCount = maxW < 550 ? 1 : (maxW < 904 ? 2 : 3);
                  return AutoHeightGridView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      crossAxisCount: crossAxisCount,
                      itemCount: notifications.length,
                      builder: (context, index) {
                        final notification = notifications[index];
                        return AnnouncementCard(
                          author: notification['author'] ?? '',
                          date: notification['date'] ?? '',
                          title: notification['title'] ?? '',
                          desc: notification['desc'] ?? '',
                          link: notification['link'] ?? '',
                        );
                      });
                },
              ),
      ),
    );
  }
}
