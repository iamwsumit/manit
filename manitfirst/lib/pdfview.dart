import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFView extends StatefulWidget {
  final String filePath;
  final String title;
  final int fileType; // 0 for URL, 1 for asset and 2 for downloaded files

  const PDFView(
      {super.key,
      required this.filePath,
      required this.title,
      required this.fileType});

  @override
  State<PDFView> createState() => PDFViewState();
}

class PDFViewState extends State<PDFView> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.filePath);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text(widget.title),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: (widget.fileType == 1
                    ? SfPdfViewer.asset(widget.filePath)
                    : widget.fileType == 2
                        ? SfPdfViewer.file(File(widget.filePath))
                        : SfPdfViewer.network(widget.filePath)))));
  }
}
