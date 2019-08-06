import 'package:flutter/material.dart';
class NoteList extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    var noteListState = NoteListState();
        return noteListState;
  }
}

class NoteListState extends State<NoteList> {

	int count = 0;

	@override
  Widget build(BuildContext ctx) {

    return Scaffold(


	    appBar: AppBar(
		    title: Text('Appointment Management'),
	    ),

	    body: getNoteListView(),
      
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                debugPrint('FAB clicked');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NoteList();
                }));
              },
      
              tooltip: 'Add new Appointment',
      
              child: Icon(Icons.add),
      
            ),
          );
        }
      
        getNoteListView() {}
}

