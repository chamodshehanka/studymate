import 'package:flutter/material.dart';
import "package:carousel_slider/carousel_slider.dart";

class CreateSchedule extends StatefulWidget {
  final int id;
  CreateSchedule({Key key, this.id}) : super(key: key);
  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  int counter = 0;
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  List<String> days = new List();
 
  CarouselSlider instance;
  @override
  void initState() {
    super.initState();
    days.add("Sunday");
    days.add("Monday");
    days.add("Tuesday");
    days.add("Wednesday");
    days.add("Thursday");
    days.add("Friday");
    days.add("Saturday");
  }

  @override
  Widget build(BuildContext context) {
  
    instance = new CarouselSlider(
      initialPage: widget.id,
      items: days.map((d) {
        return new Container(
            width: 400,
            margin: new EdgeInsets.symmetric(horizontal: 5.0),
            decoration: new BoxDecoration(color: Colors.amber),
            child: Stack(
              children: <Widget>[
                Text(d),
                Positioned(
                    bottom: 20,
                    right: 0,
                    child: RawMaterialButton(
                      onPressed: () => {
                     showDialog(
            context: context,
            builder: (_) {
              return MyDialog();
            })
                      },
                      child: Icon(
                        Icons.add,
                        size: 45.0,
                        color: Colors.white,
                      ),
                      shape: new CircleBorder(),
                      fillColor: Colors.red,
                      elevation: 2.0,
                    ))
              ],
            ));
      }).toList(),
      height: 550,
      autoPlay: false,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("StudyMate"),
          backgroundColor: Colors.deepOrange,
        ),
        backgroundColor: Colors.white,
        body: instance);
  }
}

class Data {
  int id;
  Data(int id) {
    this.id = id;
  }
}


class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
   TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime =
      TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
    final _formKey = GlobalKey<FormState>();
    var type;
    var activity;

    Future<Null> selectStartTime(BuildContext context) async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _startTime);

      if (picked != null) {
        print('Start Time : ${_startTime.toString()}');
        setState(() {
          _startTime = picked;
        });
      }
    }

    Future<Null> selectEndTime(BuildContext context) async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _endTime);

      if (picked != null) {
        print('End Time : ${_endTime.toString()}');
        setState(() {
          _endTime = picked;
        });
      }
    }
  
  @override
  Widget build(BuildContext context) {
   return AlertDialog(
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      DropdownButtonFormField<String>(
                                        value: type,
                                        hint: Text('Select Type'),
                                        items: ["Study", "Leisure", "Social"]
                                            .map((label) => DropdownMenuItem(
                                                  child: Text(label),
                                                  value: label,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() => type = value);
                                        },
                                      ),
                                      DropdownButtonFormField<String>(
                                        hint: Text('Select Subject/Activity'),
                                        value: activity,
                                        items: ["Science", "Mathematics", "History"]
                                            .map((label) => DropdownMenuItem(
                                                  child: Text(label),
                                                  value: label,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() => activity = value);
                                        },
                                      ),
                                      Text(
                                          'Start Time:${_startTime.toString()}'),
                                      Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                              child: Text('Select Start Time'),
                                              onPressed: () {
                                                selectStartTime(context);
                                              })),
                                      Text('End Time:${_endTime.toString()}'),
                                      Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                              child: Text('Select End Time'),
                                              onPressed: () {
                                                selectEndTime(context);
                                              })),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          child: Text("Add To Schedule"),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
  }
}
