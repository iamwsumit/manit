import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manitfirst/utils/utility.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFView extends StatefulWidget {
  final String filePath;
  final String title;
  final bool isAsset;

  const PDFView(
      {super.key,
      required this.filePath,
      required this.title,
      required this.isAsset});

  @override
  State<PDFView> createState() => PDFViewState();
}

class PDFViewState extends State<PDFView> {
  @override
  Widget build(BuildContext context) {
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
                child: widget.isAsset
                    ? SfPdfViewer.asset(
                        enableDoubleTapZooming: true, widget.filePath)
                    : SfPdfViewer.file(
                        enableDoubleTapZooming: true, File(widget.filePath)))));
  }
}
