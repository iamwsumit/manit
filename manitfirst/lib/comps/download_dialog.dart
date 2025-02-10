import 'package:flutter/material.dart';

import '../utils/dimen.dart';

class DownloadDialog extends StatefulWidget {
  final String title;
  final String subtitle;

  const DownloadDialog(
      {super.key, required this.title, required this.subtitle});

  @override
  State<DownloadDialog> createState() => DownloadDialogState();
}

class DownloadDialogState extends State<DownloadDialog> {
  double progress = 0;
  void updateProgress(double progress){
    setState(() {
      this.progress = progress;
    });
  }
  @override
  Widget build(BuildContext context) {
    final progressColor = Theme.of(context).primaryColor;

    return Dialog(
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Dimen.listViewCardRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircularProgressIndicator(
                      value: 1,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressColor.withOpacity(0.2),
                      ),
                      strokeWidth: 8,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      value: progress,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      strokeWidth: 8,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headlineSmall?.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: Dimen.getListViewTitleStyle(context),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: Dimen.getListViewSubTitleStyle(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}