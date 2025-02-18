import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'comps/pdfcontrols.dart';

class PDFView extends StatefulWidget {
  final String filePath;
  final String title;
  final int fileType;

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
  double _currentWidth = 600;
  int _currentPage = 1;
  int _totalPages = 0;
  bool _isInitialized = false;

  // Cache key for the current document
  late final String _cacheKey;

  @override
  void initState() {
    super.initState();
    _cacheKey = widget.filePath.hashCode.toString();
    _pdfViewerController.addListener(_handlePageChange);

    // Delayed initialization to improve initial load time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePdfViewer();
    });
  }

  void _handlePageChange() {
    if (mounted && _pdfViewerController.pageNumber != _currentPage) {
      setState(() {
        _currentPage = _pdfViewerController.pageNumber;
      });
    }
  }

  Future<void> _initializePdfViewer() async {
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _pdfViewerController.removeListener(_handlePageChange);
    _pdfViewerController.dispose();
    super.dispose();
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
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                    progressBarColor: Theme.of(context).primaryColor,
                  ),
                  child: _buildOptimizedPdfViewer(),
                ),
              ),
            ),
          ),
          if (_isInitialized)
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

  Widget _buildOptimizedPdfViewer() {
    Widget buildViewer(dynamic source) {
      return source is String
          ? (widget.fileType == 1
          ? SfPdfViewer.asset(source,
        key: ValueKey('asset_${_cacheKey}'),
        controller: _pdfViewerController,
        interactionMode: PdfInteractionMode.pan,
        maxZoomLevel: 5.0,
        enableDoubleTapZooming: false,
        enableTextSelection: false,
        pageSpacing: 0,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          setState(() {
            _totalPages = details.document.pages.count;
          });
        },
        canShowScrollHead: false,
        enableDocumentLinkAnnotation: false,
        initialZoomLevel: 1.0,
        canShowHyperlinkDialog: false,
        canShowPaginationDialog: false,
        canShowTextSelectionMenu: false,
        canShowPasswordDialog: false,
        canShowSignaturePadDialog: false,
        scrollDirection: PdfScrollDirection.vertical,
      )
          : SfPdfViewer.network(source,
        key: ValueKey('network_${_cacheKey}'),
        controller: _pdfViewerController,
        interactionMode: PdfInteractionMode.pan,
        maxZoomLevel: 5.0,
        enableDoubleTapZooming: false,
        enableTextSelection: false,
        pageSpacing: 0,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          setState(() {
            _totalPages = details.document.pages.count;
          });
        },
        canShowScrollHead: false,
        enableDocumentLinkAnnotation: false,
        initialZoomLevel: 1.0,
        canShowHyperlinkDialog: false,
        canShowPaginationDialog: false,
        canShowTextSelectionMenu: false,
        canShowPasswordDialog: false,
        canShowSignaturePadDialog: false,
        scrollDirection: PdfScrollDirection.vertical,
      ))
          : SfPdfViewer.file(source,
        key: ValueKey('file_${_cacheKey}'),
        controller: _pdfViewerController,
        interactionMode: PdfInteractionMode.pan,
        maxZoomLevel: 5.0,
        enableDoubleTapZooming: false,
        enableTextSelection: false,
        pageSpacing: 0,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          setState(() {
            _totalPages = details.document.pages.count;
          });
        },
        canShowScrollHead: false,
        enableDocumentLinkAnnotation: false,
        initialZoomLevel: 1.0,
        canShowHyperlinkDialog: false,
        canShowPaginationDialog: false,
        canShowTextSelectionMenu: false,
        canShowPasswordDialog: false,
        canShowSignaturePadDialog: false,
        scrollDirection: PdfScrollDirection.vertical,
      );
    }

    switch (widget.fileType) {
      case 1:
        return buildViewer(widget.filePath);
      case 2:
        return buildViewer(File(widget.filePath));
      default:
        return buildViewer(widget.filePath);
    }
  }
}