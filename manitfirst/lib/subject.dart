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
  List<Tab> tabs = [];
  Map<String, List<dynamic>> tabValues = {};
  late String dirPath;

  @override
  void initState() {
    super.initState();
    utils = Utils(context: context);
    initialize();
  }

  void initialize() async {
    dirPath = (await getApplicationSupportDirectory()).path;
    data = widget.data;
    final Map<String, dynamic> sData = data['data'] ?? {};

    if (sData.keys.isEmpty) {
      Future.microtask(() {
        Utils.showToast(msg: 'No Data for this subject');
        if (context.mounted) {
          dismissDialog();
        }
      });
      return;
    }

    for (final e in sData.entries) {
      tabs.add(Tab(text: e.key));
      tabValues[e.key] = List<dynamic>.from(e.value);
    }


    setState(() {
      isLoading = false;
    });
  }

  Widget buildWidget(List<dynamic> values) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxW = constraints.maxWidth;
        int crossAxisCount = maxW < 900 ? 1 : (maxW < 1504 ? 2 : (maxW < 1800 ? 3 : 4));

        return AutoHeightGridView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          crossAxisCount: crossAxisCount,
          itemCount: values.length,
          builder: (context, index) {
            final item = values[index];
            return ListCard(
              index: index,
              title: item['title'],
              desc: item['desc'],
              isDownloaded: isDownloaded(item['link']),
              download: download,
              removeFile: removeFile,
              link: item['link'],
            );
          },
        );
      },
    );
  }

  bool isDownloaded(String fileName) {
    try {
      fileName = getFileName(fileName);
      final file = File('$dirPath/$fileName');
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

  void removeFile(ListCard card) async {
    try {
      final fileName = getFileName(card.link);
      final filePath = '$dirPath/$fileName';

      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        Utils.showToast(msg: 'File deleted successfully');

        setState(() {});
      } else {
        Utils.showToast(msg: 'File not found for deletion');
      }
    } catch (e) {
      dismissDialog();
      debugPrint("Error during removing file operation: $e");
      Utils.showToast(msg: 'Failed to remove file');
    }
  }

  void dismissDialog() {
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void download(ListCard card) async {
    try {
      final name = card.title;
      final link = card.link;
      final fileName = getFileName(link);
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

      debugPrint('Downloading file : $fileName from\nURL : $link');

      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DownloadDialog(
            key: dialogKey,
            title: name,
          ),
        );
      }

      await dio.download(
        link,
        file.path,
        onReceiveProgress: (count, totalSize) {
          if (totalSize > 0) {
            received = count;
            total = totalSize;
            double progress = (received / total);
            String download = '${formatFileSize(received)} of ${formatFileSize(total)}';
            dialogKey.currentState?.updateProgress(progress, download);
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

  String formatFileSize(int bytes) {
    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (bytes < kb) {
      return '$bytes B';
    } else if (bytes < mb) {
      double sizeInKb = bytes / kb;
      return '${sizeInKb.toStringAsFixed(1)}KB';
    } else if (bytes < gb) {
      double sizeInMb = bytes / mb;
      return '${sizeInMb.toStringAsFixed(1)}MB';
    } else {
      double sizeInGb = bytes / gb;
      return '${sizeInGb.toStringAsFixed(1)}GB';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: MyTheme.primary),
        ),
      );
    }

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: MyTabBar(tabs: tabs),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(data['name']),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: TabBarView(
          children: tabs.map((tab) => buildWidget(tabValues[tab.text] ?? [])).toList(),
        ),
      ),
    );
  }
}