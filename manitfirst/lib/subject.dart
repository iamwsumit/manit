import 'dart:convert';
import 'dart:io';

import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manitfirst/comps/list.dart';

import 'package:manitfirst/utils/theme.dart';
import 'package:manitfirst/utils/utility.dart';
import 'package:path_provider/path_provider.dart';
import 'comps/download_dialog.dart';
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

  late String dirPath;

  @override
  void initState() {
    utils = Utils(context: context);
    initialize();
    super.initState();
  }

  void initialize() async {
    dirPath = (await getApplicationSupportDirectory()).path;
    data = widget.data;
    final Map<String, dynamic> sData = data['data'] ?? {};
    if (sData.keys.isEmpty) {
      Future.microtask(() {
        Utils.showToast(msg: 'Invalid Subject or data not found');
        if (context.mounted) {
          Navigator.pop(context);
        }
      });
      return;
    }
    for (final e in sData.entries) {
      tabs.add(Tab(text: e.key));
      final List<dynamic> values = e.value;
      children.add(buildWidget(values));
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildWidget(List<dynamic> values) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxW = constraints.maxWidth;
      int crossAxisCount =
          maxW < 900 ? 1 : (maxW < 1504 ? 2 : (maxW < 1800 ? 3 : 4));
      return AutoHeightGridView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          crossAxisCount: crossAxisCount,
          itemCount: values.length,
          builder: (context, index) {
            return ListCard(
                index: index,
                title: values.elementAt(index)['title'],
                desc: values.elementAt(index)['desc'],
                isDownloaded: isDownloaded(values.elementAt(index)['title']),
                download: download,
                removeFile: removeFile,
                link: values.elementAt(index)['link']);
          });
    });
  }

  final List<Tab> tabs = [];
  final List<Widget> children = [];

  bool isDownloaded(String fileName) {
    try {
      fileName = getFileName(fileName);
      final file = File('$dirPath/$fileName');
      debugPrint(file.path);
      return file.existsSync();
    } catch (e) {
      debugPrint("Error checking if file is downloaded: $e");
      return false;
    }
  }

  static String getFileName(String fileName) {
    final name = fileName.replaceAll(' ', '-').toLowerCase();
    final hash = md5.convert(utf8.encode(name)).toString();
    return '$hash.pdf';
  }

  void removeFile(String name) async {
    try {
      final fileName = getFileName(name);
      final filePath = '$dirPath/$fileName';

      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        Utils.showToast(msg: 'File deleted successfully');
      } else {
        Utils.showToast(msg: 'File not found for deletion');
      }

      setState(() {});
    } catch (e) {
      dismissDialog();
      debugPrint("Error during removing file operation: $e");
      Utils.showToast(msg: 'Failed to remove file');
    }
  }

  void dismissDialog() {
    Navigator.pop(context);
  }

  void download(String name, String link) async {
    try {
      final fileName = getFileName(name);
      final filePath = '$dirPath/$fileName';

      Dio dio = Dio();

      int received = 0;
      int total = 1;

      final directory = await getApplicationSupportDirectory();
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final file = File(filePath);

      final dialogKey = GlobalKey<DownloadDialogState>();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => DownloadDialog(
          key: dialogKey,
          title: 'Download PDF',
          subtitle: name,
        ),
      );

      await dio.download(
        link,
        file.path,
        onReceiveProgress: (count, totalSize) {
          if (totalSize > 0) {
            received = count;
            total = totalSize;
            double progress = (received / total);
            dialogKey.currentState?.updateProgress(progress);
          }
        },
      );

      dismissDialog();
      Utils.showToast(msg: 'File downloaded successfully');

      setState(() {});
    } catch (e) {
      dismissDialog();
      debugPrint("Error during download operation: $e");
      Utils.showToast(msg: 'Failed to download file');
    }
  }

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
