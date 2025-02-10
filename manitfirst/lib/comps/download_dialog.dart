import 'package:flutter/material.dart';
import 'package:manitfirst/utils/theme.dart';

import '../utils/dimen.dart';

class DownloadDialog extends StatefulWidget {
  final String title;

  const DownloadDialog({super.key, required this.title});

  @override
  State<DownloadDialog> createState() => DownloadDialogState();
}

class DownloadDialogState extends State<DownloadDialog> {
  double progress = 0;
  String download = '';

  void updateProgress(double progress, String download) {
    setState(() {
      this.progress = progress;
      this.download = download;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    width = width > 400 ? 400 : width;
    return Dialog(
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Dimen.listViewCardRadius,
      ),
      child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Downloading ${widget.title}...',
                  style: Dimen.getListViewTitleStyle(context)
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(8),
                    backgroundColor: MyTheme.halkaPrimary,
                    color: MyTheme.primary,
                    value: progress),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      download,
                      style: Dimen.getListViewSubTitleStyle(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: Dimen.getListViewSubTitleStyle(context),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
