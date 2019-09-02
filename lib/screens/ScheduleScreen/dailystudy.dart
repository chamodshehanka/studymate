//import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:device_calendar/device_calendar.dart';

class DailyStudy extends StatefulWidget {
  DailyStudy({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _DailyStudyState createState() => _DailyStudyState();
}

class _DailyStudyState extends State<DailyStudy> {
  List subjects;
  // DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();
  // List<Calendar> _calendars;
  // List<Event> _events;
 
  @override
  void initState() {
    //_retrieveCalendars();
    subjects = getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Subject subject) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(subject),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(subjects[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
    );
  }

  makeListTile(Subject subject) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Text(
          subject.time,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        subject.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
      onTap: () => {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Rate Performance"),
                    content: TextField(
                      controller: TextEditingController(),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        elevation: 5.0,
                        child: Text("Submit",
                            style: TextStyle(color: Colors.blueAccent)),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(TextEditingController().text.toString());
                        },
                      )
                    ],
                  );
                })
          });

  //  void _retrieveCalendars() async {
  //   try {
  //     var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
  //     if (permissionsGranted.isSuccess && !permissionsGranted.data) {
  //       permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
  //       if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
  //         return;
  //       }
  //     }

  //     final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
  //     setState(() {
  //       _calendars = calendarsResult?.data;
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }
  //         void _retrieveCalendarDailyEvents() async {
  //   final startDate = DateTime.now().add(Duration(days: -30));
  //   final endDate = DateTime.now().add(Duration(days: 30));
      
  //   var calendarEventsResult = await _deviceCalendarPlugin.retrieveEvents(
  //       _calendars[4].id,
  //       RetrieveEventsParams(startDate: startDate, endDate: endDate));
  //      setState(() {
  //       _events = calendarEventsResult?.data;
  //     });
  }




List getSubjects() {
  // _retrieveCalendarDailyEvents();
  // List<Subject> studyEvents;
  //   if(_events.isEmpty){
  //     print("Schedule Is Empty");
  //   }
  //   else{
  //   for(Event event in _events){
  //     if(event.description=="study"){
  //       studyEvents.add(Subject(event.title,event.start.toString()));
  //     }
  //   }
  //   }
  //   return studyEvents;
  return[
    Subject("Mathematics", "8.00 - 9.30"),
    Subject("Science", "10.30 - 12.00"),
    Subject("English", "12.30 - 13.30"),
    Subject("Sinhala", "15.00 - 16.00"),
    Subject("History", "16.00 - 17.00"),
  ];
//}
}


class Subject {
  String title;
  String time;
  Subject(this.title, this.time);
}