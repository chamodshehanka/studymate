import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  final Event _calendarEvent;
  final DeviceCalendarPlugin _deviceCalendarPlugin;

  final Function(Event) _onTapped;
  final VoidCallback _onLoadingStarted;
  final Function(bool) _onDeleteFinished;

  final double _eventFieldNameWidth = 100.0;

  EventItem(this._calendarEvent, this._deviceCalendarPlugin,
      this._onLoadingStarted, this._onDeleteFinished, this._onTapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTapped(_calendarEvent);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: FlutterLogo(),
            ),
            ListTile(
                title: Text(_calendarEvent.title ?? ''),
                subtitle: Text(_calendarEvent.description ?? '')),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(_calendarEvent.start.weekday.toString()),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Container(
                          width: _eventFieldNameWidth,
                          child: Text('Starts'),
                        ),
                        Text(_calendarEvent == null
                            ? ''
                            : DateFormat.yMd()
                                .add_jm()
                                .format(_calendarEvent.start)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Container(
                          width: _eventFieldNameWidth,
                          child: Text('Ends'),
                        ),
                        Text(_calendarEvent.end == null
                            ? ''
                            : DateFormat.yMd()
                                .add_jm()
                                .format(_calendarEvent.end)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            ButtonTheme.bar(
                child: ButtonBar(
              children: [
                IconButton(
                  onPressed: () {
                    _onTapped(_calendarEvent);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    await showDialog<Null>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                'Are you sure you want to delete this event?'),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  _onLoadingStarted();
                                  final deleteResult =
                                      await _deviceCalendarPlugin.deleteEvent(
                                          _calendarEvent.calendarId,
                                          _calendarEvent.eventId);
                                  _onDeleteFinished(deleteResult.isSuccess &&
                                      deleteResult.data);
                                },
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}