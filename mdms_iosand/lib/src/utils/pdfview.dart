import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_extend/share_extend.dart';

class PdfView extends StatelessWidget {
  final String? path;
  final String? pdftitle;
  const PdfView({super.key, this.path, this.pdftitle});

  @override
  Widget build(BuildContext context) {
    /*
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Tooltip(message: path, child: Text(pdftitle)),
        actions: [
          FlatButton.icon(
            onPressed: () async {
              _shareStorageFile();
            },
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            label: Text(
              'Share',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      path: path,
    );
    */
    return Scaffold(
      appBar: AppBar(
        title: Tooltip(message: path!, child: Text(pdftitle!)),
        actions: [
          TextButton.icon(
            onPressed: () async {
              _shareStorageFile();
            },
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            label: const Text(
              'Share',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
          )
        ],
      ),
    );
  }

  // Share Storage File
  _shareStorageFile() async {
    ShareExtend.share(path!, "file");
  }
}