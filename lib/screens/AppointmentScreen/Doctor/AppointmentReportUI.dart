import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfPackage;

class AppointmentReportScreen extends StatefulWidget {
  _AppointmentReportScreenState createState() => _AppointmentReportScreenState();
}

class _AppointmentReportScreenState extends State<AppointmentReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePDFAndView(context),
          ),
        ],
      ),
      body: Container(),
    );
  }

  _generatePDFAndView(context) async {
    final pdf = pdfPackage.Document();

    pdf.addPage(pdfPackage.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pdfPackage.Context context) {
          return pdfPackage.Container(child: pdfPackage.Text('Hello world'));
          // return pdfPackage.Text('Hello world');
        }));

    final String dir = (await getApplicationDocumentsDirectory()).path;
    print('dir : ' + dir);
    final String path = '$dir/report.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
  }
}
