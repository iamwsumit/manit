import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:manitfirst/subject.dart';
import 'package:manitfirst/utils/theme.dart';
import 'package:manitfirst/utils/utility.dart';
import 'package:path_provider/path_provider.dart';

class AndroidPDFView extends StatefulWidget {
  final String filePath;
  final String title;
  final int fileType; // 0 for URL, 1 for asset and 2 for downloaded files

  const AndroidPDFView({
    super.key,
    required this.filePath,
    required this.title,
    required this.fileType,
  });

  @override
  State<AndroidPDFView> createState() => AndroidPDFViewState();
}

class AndroidPDFViewState extends State<AndroidPDFView> {
  @override
  void initState() {
    super.initState();
    configure();
  }

  void configure() async {
    final dirPath = (await getApplicationSupportDirectory()).path;
    if (widget.fileType == 1) {
      if (SubjectState.isDownloaded(dirPath, widget.title)) {
        debugPrint('File is already saved, showing the pdf');
        setState(() {
          file = File('$dirPath/${SubjectState.getFileName(widget.title)}');
        });
      } else {
        debugPrint('Asset is not saved in file, converting...');
        fromAsset(widget.filePath, SubjectState.getFileName(widget.title))
            .then((val) {
          setState(() {
            file = val;
          });
        });
      }
    } else if (widget.fileType == 0) {
      if (SubjectState.isDownloaded(dirPath, widget.filePath)) {
        debugPrint('File is already downloaded, showing the pdf');
        setState(() {
          file = File('$dirPath/${SubjectState.getFileName(widget.filePath)}');
        });
      } else {
        createFileOfPdfUrl(
                widget.filePath, SubjectState.getFileName(widget.filePath))
            .then((val) {
          setState(() {
            file = val;
          });
        });
      }
    } else {
      setState(() {
        file = File(widget.filePath);
      });
    }
  }

  Future<File> createFileOfPdfUrl(String url, String fileName) async {
    Completer<File> completer = Completer();
    try {
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationSupportDirectory();
      print("Download files");
      File file = File("${dir.path}/$fileName");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      Utils.showToast(msg: 'Something went wrong while parsing PDF');
      Navigator.pop(context);
    }

    return completer.future;
  }

  File? file;

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationSupportDirectory();
      File file = File("${dir.path}/$filename");
      debugPrint(file.path);
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      Utils.showToast(msg: 'Something went wrong while parsing PDF');
      Navigator.pop(context);
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.filePath);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: (file == null)
          ? Center(child: CircularProgressIndicator(color: MyTheme.primary))
          : PDFView(
              pageSnap: false,
              pageFling: false,
              nightMode: Utils.isDarkTheme(),
              autoSpacing: false,
              filePath: file!.path,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              fitPolicy: FitPolicy.WIDTH,
              preventLinkNavigation: true,
            ),
    );
  }
}