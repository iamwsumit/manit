import 'package:flutter/material.dart';
import '../utils/dimen.dart';
import '../utils/theme.dart';

class ListCard extends StatelessWidget {
  final int index;
  final String title;
  final String desc;
  final bool isDownloaded;
  final Function(String name, String link) download;
  final Function(String name) removeFile;
  final String link;

  const ListCard(
      {super.key,
      required this.index,
      required this.title,
      required this.desc,
      required this.isDownloaded, required this.download, required this.removeFile, required this.link});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  style: Dimen.getListViewTitleStyle(context).copyWith(fontSize: 16)),
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
                  removeFile(title);
                } else {
                  download(title, link);
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: MyTheme.halkaPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    isDownloaded ? 'Remove' : 'Download',
                  )))
        ],
      )),
    );
  }
}
