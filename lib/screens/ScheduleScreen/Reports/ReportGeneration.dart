
import 'dart:io';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:studymate/screens/ScheduleScreen/Reports/ReportViewer.dart';
import 'package:studymate/services/custom/StudentService.dart';

class ReportGeneration extends StatelessWidget {

  final StudentService studentService = new StudentService();
  var data = {
          "Task":"Singing",
          "Completed":"45",
          "Schedules":"60"
        };

  ReportGeneration({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pdf - generate and view'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdfAndView(context),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container()
    );
  }

  _generatePdfAndView(context) async {
    //List<BaseballModel> data = await _databaseService.list().first;
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

    pdf.addPage(
      pdfLib.MultiPage(
        build: (context) => [
              pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
                <String>['Name', 'Coach', 'players'],
              ]),
            ],
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/baseball_teams.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReportViewer(path: path),
      ),
    );
  }
}