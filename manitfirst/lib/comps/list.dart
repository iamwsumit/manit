import 'package:flutter/material.dart';
import 'package:manitfirst/pdfview.dart';
import 'package:manitfirst/subject.dart';
import '../utils/dimen.dart';
import '../utils/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PDFView(
                      filePath:
                          isDownloaded ? SubjectState.getFileName(link) : link,
                      title: title,
                      fileType: isDownloaded ? 2 : 0))),
          child: Dimen.getListViewPadding(
              child: Row(
            spacing: Dimen.listViewRowSpacing,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: MyTheme.halkaPrimary,
                radius: 20,
                child: Text((index + 1).toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: MyTheme.primary)),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Dimen.getListViewTitleStyle(context)
                          .copyWith(fontSize: 16)),
                  Text(desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14)),
                ],
              )),
              InkWell(
                  radius: 10,
                  onTap: () {
                    if (isDownloaded) {
                      removeFile(this);
                    } else {
                      download(this);
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: MyTheme.halkaPrimary,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text(
                        isDownloaded ? 'Remove' : 'Download',
                      )))
            ],
          ))),
    );
  }
}
