import 'dart:io';
import 'package:flutter/material.dart';
import 'package:manitfirst/utils/theme.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFView extends StatefulWidget {
  final String filePath;
  final String title;
  final int fileType; // 0 for URL, 1 for asset and 2 for downloaded files

  const PDFView({
    super.key,
    required this.filePath,
    required this.title,
    required this.fileType,
  });

  @override
  State<PDFView> createState() => PDFViewState();
}

class PDFViewState extends State<PDFView> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  double _currentWidth = 600; // Initial width matching your constraints
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pdfViewerController.pageNumber;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Container(
                width: _currentWidth,
                constraints: const BoxConstraints(
                  minWidth: 500,
                  maxWidth: 1200,
                ),
                child: SfPdfViewerTheme(
                  data: SfPdfViewerThemeData(
                    backgroundColor: Colors.transparent,
                    progressBarColor: MyTheme.primary,
                  ),
                  child: _buildPdfViewer(),
                ),
              ),
            ),
          ),
          PDFBottomControls(
            controller: _pdfViewerController,
            currentWidth: _currentWidth,
            onWidthChanged: (width) {
              setState(() => _currentWidth = width);
            },
            currentPage: _currentPage,
            totalPages: _totalPages,
          ),
        ],
      ),
    );
  }

  Widget _buildPdfViewer() {
    return widget.fileType == 1
        ? SfPdfViewer.asset(
            widget.filePath,
            controller: _pdfViewerController,
            interactionMode: PdfInteractionMode.pan,
            maxZoomLevel: 5,
            onDocumentLoaded: (details) {
              setState(() {
                _totalPages = details.document.pages.count;
              });
            },
          )
        : widget.fileType == 2
            ? SfPdfViewer.file(
                File(widget.filePath),
                controller: _pdfViewerController,
                interactionMode: PdfInteractionMode.pan,
                maxZoomLevel: 5,
                onDocumentLoaded: (details) {
                  setState(() {
                    _totalPages = details.document.pages.count;
                  });
                },
              )
            : SfPdfViewer.network(
                widget.filePath,
                controller: _pdfViewerController,
                interactionMode: PdfInteractionMode.pan,
                maxZoomLevel: 5,
                onDocumentLoaded: (details) {
                  setState(() {
                    _totalPages = details.document.pages.count;
                  });
                },
              );
  }
}

class PDFBottomControls extends StatelessWidget {
  final PdfViewerController controller;
  final Function(double) onWidthChanged;
  final double currentWidth;
  final int currentPage;
  final int totalPages;

  const PDFBottomControls({
    Key? key,
    required this.controller,
    required this.onWidthChanged,
    required this.currentWidth,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);

  void _decreaseWidth() {
    final newWidth = currentWidth * 0.9; // Decrease by 10%
    if (newWidth >= 500) {
      onWidthChanged(newWidth);
    }
  }

  void _increaseWidth() {
    final newWidth = currentWidth * 1.1; // Increase by 10%
    if (newWidth <= 1200) {
      onWidthChanged(newWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool show = MediaQuery.sizeOf(context).width > 550;
    final Color? color = Theme.of(context).textTheme.bodySmall?.color;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              IconButton(
                icon: Icon(Icons.zoom_out, color: color),
                onPressed: () {
                  controller.zoomLevel =
                      (controller.zoomLevel - 0.25).clamp(0.25, 5.0);
                },
                tooltip: 'Zoom Out',
              ),
              const SizedBox(width: 16),
              if (show) ...[
                IconButton(
                  icon: Icon(Icons.width_normal, color: color),
                  onPressed: _decreaseWidth,
                  tooltip: 'Decrease Width',
                ),
              ],
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: color,
                ),
                onPressed:
                    currentPage > 1 ? () => controller.previousPage() : null,
                tooltip: 'Previous Page',
              ),
              const SizedBox(width: 8),
              Text(
                '$currentPage / $totalPages',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500, color: color),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: color),
                onPressed: currentPage < totalPages
                    ? () => controller.nextPage()
                    : null,
                tooltip: 'Next Page',
              ),
              const SizedBox(width: 16),
              if (show) ...[
                IconButton(
                  icon: Icon(Icons.width_wide, color: color),
                  onPressed: _increaseWidth,
                  tooltip: 'Increase Width',
                ),
              ],
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.zoom_in, color: color),
                color: color,
                onPressed: () {
                  controller.zoomLevel =
                      (controller.zoomLevel + 0.25).clamp(0.25, 5.0);
                },
                tooltip: 'Zoom In',
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
