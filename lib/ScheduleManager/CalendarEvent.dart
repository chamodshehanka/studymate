import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studymate/ScheduleManager/DateTimePicker.dart';
import 'package:studymate/ScheduleManager/DayOfTheWeek.dart';
import 'package:studymate/ScheduleManager/EventReminders.dart';
import 'package:studymate/ScheduleManager/Reminder.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/custom/ActivityService.dart';

enum RecurrenceRuleEndType { MaxOccurrences, SpecifiedEndDate }

class CalendarEventPage extends StatefulWidget {
  final Calendar _calendar;
  final Event _event;
  List<Activity> activityTypes;
  List<Activity> socialActivities;
  List<Activity> leisureActivities;
  List<Activity> subjects;
  ActivityService activityService = new ActivityService();
  StreamSubscription<QuerySnapshot> activitySubscription;

  CalendarEventPage(this._calendar, [this._event]);

  
  @override
  _CalendarEventPageState createState() => _CalendarEventPageState(_calendar,_event);

  @override
  void initState(){
    socialActivities = List();
    leisureActivities = List();

    activitySubscription?.cancel();
    activitySubscription = activityService
        .getLeisureActivityList()
        .listen((QuerySnapshot snapshot) {
      final List<Activity> activities = snapshot.documents
          .map((documentSnapshot) => Activity.fromMap(documentSnapshot.data))
          .toList();

          leisureActivities = activities;
    } 
    );

    activitySubscription = activityService
        .getSocialActivityList()
        .listen((QuerySnapshot snapshot) {
      final List<Activity> activities = snapshot.documents
          .map((documentSnapshot) => Activity.fromMap(documentSnapshot.data))
          .toList();

          socialActivities = activities;
    } 
    );
  }
}

class _CalendarEventPageState extends State<CalendarEventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Calendar _calendar;

  Event _event;
  DeviceCalendarPlugin _deviceCalendarPlugin;

  DateTime _startDate;
  TimeOfDay _startTime;

  DateTime _endDate;
  TimeOfDay _endTime;

  bool _autovalidate = false;
  bool _isRecurringEvent = true;


  List<DayOfTheWeek> _daysOfTheWeek = List<DayOfTheWeek>();
  List<int> _daysOfTheMonth = List<int>();
  List<int> _monthsOfTheYear = List<int>();
  List<int> _weeksOfTheYear = List<int>();
  List<int> _setPositions = List<int>();
  List<int> _validDaysOfTheMonth = List<int>();
  List<int> _validMonthsOfTheYear = List<int>();
  List<int> _validWeeksOfTheYear = List<int>();
  List<Reminder> _reminders = List<Reminder>();


  RecurrenceFrequency _recurrenceFrequency = RecurrenceFrequency.Daily;

  _CalendarEventPageState(this._calendar, this._event) {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
    for (var i = -31; i <= -1; i++) {
      _validDaysOfTheMonth.add(i);
    }
    for (var i = 1; i <= 31; i++) {
      _validDaysOfTheMonth.add(i);
    }
    for (var i = 1; i <= 12; i++) {
      _validMonthsOfTheYear.add(i);
    }
    for (var i = -53; i <= -1; i++) {
      _validWeeksOfTheYear.add(i);
    }
    for (var i = 1; i <= 53; i++) {
      _validWeeksOfTheYear.add(i);
    }
 
    _reminders = List<Reminder>();
    if (this._event == null) {
      _startDate = DateTime.now();
      _endDate = DateTime.now().add(Duration(hours: 1));
      _event = Event(this._calendar.id, start: _startDate, end: _endDate);
    
    } else {
      _startDate = _event.start;
      _endDate = _event.end;
      _isRecurringEvent = _event.recurrenceRule != null;
  
      // if (_event.reminders.isNotEmpty) {
      //   _reminders.addAll(_event.reminders);
      // }
      // if (_isRecurringEvent) {
      //   _recurrenceFrequency = _event.recurrenceRule.recurrenceFrequency;
        
      //   _daysOfTheWeek =
      //       _event.recurrenceRule.daysOfTheWeek ?? List<DayOfTheWeek>();
      //   _daysOfTheMonth = _event.recurrenceRule.daysOfTheMonth ?? List<int>();
      //   _monthsOfTheYear = _event.recurrenceRule.monthsOfTheYear ?? List<int>();
      //   _weeksOfTheYear = _event.recurrenceRule.weeksOfTheYear ?? List<int>();
      //   _setPositions = _event.recurrenceRule.setPositions ?? List<int>();
      // }
    }

    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(_event.eventId?.isEmpty ?? true
            ? 'Create event'
            : 'Edit event ${_event.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              autovalidate: _autovalidate,
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                    DropdownButtonFormField(
                      value: _event.description,
                      validator: (value){
                        if(value==null){
                          return "Select Type";
                        }
                      },
                      hint: Text('Select Type'),
                        items: ["Study", "Leisure", "Social"]
                                            .map((label) => DropdownMenuItem(
                                                  child: Text(label),
                                                  value: label,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() => _event.description = value);
                                        },
                                        onSaved:(String value){
                                          _event.description=value;
                                        }

                    )),
                  Padding(
                    padding:const EdgeInsets.all(10.0),
                    child:
                    DropdownButtonFormField(
                      key: Key('titleField'),
                      value: _event.title,
                      validator: (value){
                        if(value==null){
                          return "Select Activity/Subject";
                        }
                      },
                      hint: Text('Select Activity/Subject'),
                        items: ["Maths", "Science", "History"]
                                            .map((label) => DropdownMenuItem(
                                                  child: Text(label),
                                                  value: label,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() => _event.title = value);
                                        },
                                        onSaved:(String value){
                                          _event.title=value;
                                        }

                    )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DateTimePicker(
                      labelText: 'From',
                      selectedDate: _startDate,
                      selectedTime: _startTime,
                      selectDate: (DateTime date) {
                        setState(() {
                          _startDate = date;
                          _event.start =
                              _combineDateWithTime(_startDate, _startTime);
                        });
                      },
                      selectTime: (TimeOfDay time) {
                        setState(
                          () {
                            _startTime = time;
                            _event.start =
                                _combineDateWithTime(_startDate, _startTime);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DateTimePicker(
                      labelText: 'To',
                      selectedDate: _endDate,
                      selectedTime: _endTime,
                      selectDate: (DateTime date) {
                        setState(
                          () {
                            _endDate = date;
                            _event.end =
                                _combineDateWithTime(_endDate, _endTime);
                          },
                        );
                      },
                      selectTime: (TimeOfDay time) {
                        setState(
                          () {
                            _endTime = time;
                            _event.end =
                                _combineDateWithTime(_endDate, _endTime);
                          },
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      List<Reminder> result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EventRemindersPage(_reminders)));
                      if (result == null) {
                        return;
                      }
                      _reminders = result;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10.0,
                          children: [
                            Icon(Icons.alarm),
                            if (_reminders.isEmpty) Text('Add reminders'),
                            for (var reminder in _reminders)
                              Text('${reminder.minutes} minutes before; ')
                          ],
                        ),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    value: _isRecurringEvent,
                    title: Text('Is recurring'),
                    onChanged: (isChecked) {
                      setState(() {
                        _isRecurringEvent = isChecked;
                      });
                    },
                  ),
                  if (_isRecurringEvent) ...[
                    ListTile(
                      leading: Text('Frequency'),
                      trailing: DropdownButton<RecurrenceFrequency>(
                        onChanged: (selectedFrequency) {
                          setState(() {
                            _recurrenceFrequency = selectedFrequency;
                          });
                        },
                        value: _recurrenceFrequency,
                        items: RecurrenceFrequency.values
                            .map((f) => DropdownMenuItem(
                                  value: f,
                                  child: _recurrenceFrequencyToText(f),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (_event.eventId?.isNotEmpty ?? false)
              RaisedButton(
                key: Key('deleteEventButton'),
                textColor: Colors.white,
                color: Colors.red,
                child: Text('Delete'),
                onPressed: () async {
                  await _deviceCalendarPlugin.deleteEvent(
                      _calendar.id, _event.eventId);
                  Navigator.pop(context, true);
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('saveEventButton'),
        onPressed: () async {
          final FormState form = _formKey.currentState;
          if (!form.validate()) {
            _autovalidate = true; // Start validating on every change.
            showInSnackBar('Please fix the errors in red before submitting.');
          } else {
            form.save();
            // if (_isRecurringEvent) {
            //   _event.recurrenceRule = RecurrenceRule(_recurrenceFrequency,
            //       daysOfTheWeek: _daysOfTheWeek,
            //       daysOfTheMonth: _daysOfTheMonth,
            //       monthsOfTheYear: _monthsOfTheYear,
            //       weeksOfTheYear: _weeksOfTheYear,
            //       setPositions: _setPositions);
            // }
            //_event.reminders = _reminders;
            var createEventResult =
                await _deviceCalendarPlugin.createOrUpdateEvent(_event);
            if (createEventResult.isSuccess) {
              Navigator.pop(context, true);
            } else {
              showInSnackBar(createEventResult.errorMessages.join(' | '));
            }
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Text _recurrenceFrequencyToText(RecurrenceFrequency recurrenceFrequency) {
    switch (recurrenceFrequency) {
      case RecurrenceFrequency.Daily:
        return Text('Daily');
      case RecurrenceFrequency.Weekly:
        return Text('Weekly');
      case RecurrenceFrequency.Monthly:
        return Text('Monthly');
      case RecurrenceFrequency.Yearly:
        return Text('Yearly');
      default:
        return Text('');
    }
  }

  DateTime _combineDateWithTime(DateTime date, TimeOfDay time) {
    if (date == null && time == null) {
      return null;
    }
    final dateWithoutTime =
        DateTime.parse(DateFormat("y-MM-dd 00:00:00").format(date));
    return dateWithoutTime
        .add(Duration(hours: time.hour, minutes: time.minute));
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }
}