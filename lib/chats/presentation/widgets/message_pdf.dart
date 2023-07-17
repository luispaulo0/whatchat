import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:whatchat/chats/presentation/pages/pdf_view.dart';

class MessagePdf extends StatefulWidget {
  String pdfUrl;
  MessagePdf({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<MessagePdf> createState() => _MessagePdfState();
}

class _MessagePdfState extends State<MessagePdf> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfView(pdfUrl: widget.pdfUrl),
            ),
          );
        },
        child: const SizedBox(
          width: 100,
          height: 100,
          child:  Icon(
            Icons.picture_as_pdf,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
