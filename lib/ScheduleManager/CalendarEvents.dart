import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:studymate/ScheduleManager/CalendarEvent.dart';
import 'package:studymate/ScheduleManager/EventItem.dart';

class CalendarEventsPage extends StatefulWidget {
  final Calendar _calendar;
  final String _d;

  CalendarEventsPage(this._calendar, this._d);

  @override
  _CalendarEventsPageState createState() {
    return _CalendarEventsPageState(_calendar);
  }
}

class _CalendarEventsPageState extends State<CalendarEventsPage> {
  final Calendar _calendar;
  BuildContext _scaffoldContext;

  DeviceCalendarPlugin _deviceCalendarPlugin;
  List<Event> _calendarEvents;
  //List<Event> _calendarDayEvents;
  bool _isLoading = true;

  _CalendarEventsPageState(this._calendar) {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }

  @override
  initState() {
    super.initState();
    _retrieveCalendarEvents();
  }

  @override
  Widget build(BuildContext context) {
    String day;
    return Scaffold(
      appBar: AppBar(
          title: Text('${widget._d} Events', textAlign: TextAlign.center),
          backgroundColor: Colors.amber,
          leading: new Container()),
      body: (_calendarEvents?.isNotEmpty ?? false)
          ? Stack(
              children: [
                ListView.builder(
                    itemCount: _calendarEvents?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (widget._d == 'Sunday') {
                        day = '7';
                      } else if (widget._d == 'Monday') {
                        day = '1';
                      } else if (widget._d == 'Tuesday') {
                        day = '2';
                      } else if (widget._d == 'Wednesday') {
                        day = '3';
                      } else if (widget._d == 'Thursday') {
                        day = '4';
                      } else if (widget._d == 'Friday') {
                        day = '5';
                      } else if (widget._d == 'Saturday') {
                        day = '6';
                      }

                      if (identical(
                          _calendarEvents[index].start.weekday.toString(),
                          day)) {
                        return EventItem(
                            _calendarEvents[index],
                            _deviceCalendarPlugin,
                            _onLoading,
                            _onDeletedFinished,
                            _onTapped);
                      } else {
                        return null;
                      }
                    }),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            )
          : Center(child: Text('Schedule Is Empty')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        heroTag: '${widget._d}',
        key: Key('addEventButton'),
        onPressed: () async {
          final refreshEvents = await Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CalendarEventPage(_calendar);
          }));
          if (refreshEvents == true) {
            _retrieveCalendarEvents();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _onLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  Future _onDeletedFinished(bool deleteSucceeded) async {
    if (deleteSucceeded) {
      await _retrieveCalendarEvents();
    } else {
      Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
        content: Text('Oops, we ran into an issue deleting the event'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future _onTapped(Event event) async {
    final refreshEvents = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return CalendarEventPage(_calendar, event);
    }));
    if (refreshEvents != null && refreshEvents) {
      _retrieveCalendarEvents();
    }
  }

  Future _retrieveCalendarEvents() async {
    final startDate = DateTime.now().add(Duration(days: -7));
    final endDate = DateTime.now().add(Duration(days: 7));

    var calendarEventsResult = await _deviceCalendarPlugin.retrieveEvents(
        _calendar.id,
        RetrieveEventsParams(startDate: startDate, endDate: endDate));

    setState(() {
      _calendarEvents = calendarEventsResult?.data;
      _isLoading = false;
    });
  }
}
