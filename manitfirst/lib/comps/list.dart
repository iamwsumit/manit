import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manitfirst/android_pdfview.dart';
import 'package:manitfirst/pdfview.dart';
import 'package:manitfirst/subject.dart';
import '../utils/dimen.dart';
import '../utils/theme.dart';
import 'package:path_provider/path_provider.dart';

class ListCard extends StatelessWidget {
  final int index;
  final String title;
  final String desc;
  bool isDownloaded;
  final Function(ListCard card) download;
  final Function(ListCard card) removeFile;
  final String link;

  ListCard(
      {super.key,
      required this.index,
      required this.title,
      required this.desc,
      required this.isDownloaded,
      required this.removeFile,
      required this.link,
      required this.download});

  void openPDFView(context) async {
    String filePath = link;
    if (isDownloaded) {
      final dirPath = (await getApplicationSupportDirectory()).path;
      filePath = '$dirPath/${SubjectState.getFileName(filePath)}';
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Platform.isAndroid
                ? AndroidPDFView(
                    filePath: filePath,
                    title: title,
                    fileType: isDownloaded ? 2 : 0)
                : PDFView(
                    filePath: filePath,
                    title: title,
                    fileType: isDownloaded ? 2 : 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dimen.getListViewPadding(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            style: Dimen.getListViewTitleStyle(context).copyWith(fontSize: 18)),
        Text(desc,
            // maxLines: 2,
            // overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15)),
        const SizedBox(height: 20),
        Row(
          spacing: 15,
          children: [
            Expanded(
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    radius: 10,
                    onTap: () => openPDFView(context),
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyTheme.halkaPrimary,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(
                          'View PDF',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: MyTheme.primary, fontSize: 17),
                        )))),
            Expanded(
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    radius: 10,
                    onTap: () {
                      if (isDownloaded) {
                        removeFile(this);
                      } else {
                        download(this);
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyTheme.halkaPrimary,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(
                          isDownloaded ? 'Remove' : 'Download',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: MyTheme.primary, fontSize: 17),
                        ))))
          ],
        )
      ])),
    );
  }
}
