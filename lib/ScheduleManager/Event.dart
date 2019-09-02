import 'package:device_calendar/device_calendar.dart';
import 'package:studymate/ScheduleManager/ErrorMessages.dart';
import 'package:studymate/ScheduleManager/Reminder.dart';

class Event {

  /// The unique identifier for this event
  String eventId;

  /// The identifier of the calendar that this event is associated with
  String calendarId;

  /// The title of this event
  String title;

  /// The description for this event
  String description;

  /// Indicates when the event starts
  DateTime start;

  /// Indicates when the event ends
  DateTime end;

  /// Indicates if this is an all-day event
  bool allDay;

  /// The location of this event
  String location;

  /// The recurrence rule for this event
  RecurrenceRule recurrenceRule;

  List<Reminder> reminders;

  Event(this.calendarId,
      {this.eventId,
      this.title,
      this.start,
      this.end,
      this.description,
      this.recurrenceRule,
      this.reminders});

  Event.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError(ErrorMessages.fromJsonMapIsNull);
    }

    eventId = json['eventId'];
    calendarId = json['calendarId'];
    title = json['title'];
    description = json['description'];
    int startMillisecondsSinceEpoch = json['start'];
    if (startMillisecondsSinceEpoch != null) {
      start = DateTime.fromMillisecondsSinceEpoch(startMillisecondsSinceEpoch);
    }
    int endMillisecondsSinceEpoch = json['end'];
    if (endMillisecondsSinceEpoch != null) {
      end = DateTime.fromMillisecondsSinceEpoch(endMillisecondsSinceEpoch);
    }
    allDay = json['allDay'];
    location = json['location'];

    if (json['recurrenceRule'] != null) {
      recurrenceRule = RecurrenceRule.fromJson(json['recurrenceRule']);
    }
    
    if (json['reminders'] != null) {
      reminders = json['reminders'].map<Reminder>((decodedReminder) {
        return Reminder.fromJson(decodedReminder);
      }).toList();
    }
  }

  // TODO: look at using this method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['eventId'] = eventId;
    data['calendarId'] = calendarId;
    data['title'] = title;
    data['description'] = description;
    data['start'] = start.millisecondsSinceEpoch;
    data['end'] = end.millisecondsSinceEpoch;
    data['allDay'] = allDay;
    data['location'] = location;
    if (recurrenceRule != null) {
      data['recurrenceRule'] = recurrenceRule.toJson();
    }
    if (reminders != null) {
      data['reminders'] = reminders.map((r) => r.toJson()).toList();
    }
    return data;
  }
}