import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  String pdfUrl;
  PdfView({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pdf View'),
        ),
        body: SfPdfViewer.network(
          widget.pdfUrl,
          key: pdfViewerKey,
        ));
  }
}
