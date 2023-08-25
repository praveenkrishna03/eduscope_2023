import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  final String pdfURL;

  PDFViewerPage({required this.pdfURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfURL,
        // Fit policy to decide how the PDF should be displayed
        fitPolicy: FitPolicy.WIDTH,
      ),
    );
  }
}

// Use the PDFViewerPage like this:
// PDFViewerPage(pdfURL: 'your_pdf_url_here')
