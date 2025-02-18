import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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