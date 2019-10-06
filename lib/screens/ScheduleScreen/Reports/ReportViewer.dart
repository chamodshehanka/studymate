import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class ReportViewer extends StatelessWidget {
  final String path;
  const ReportViewer({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}