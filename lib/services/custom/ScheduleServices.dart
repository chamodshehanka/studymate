import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';
//import 'package:studymate/models/Calendar.dart';


class ScheduleService{
  DeviceCalendarPlugin deviceCalendarPlugin = new DeviceCalendarPlugin();
  List<Calendar> calendars;
  Calendar calendar;

    Future<Calendar> selectCalendar()async{
    try {
      var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted =  await deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
            calendars = retrieveCalendars() as List<Calendar>;
            calendar = calendars[4];
        }
    
       
      }
       
    } on PlatformException catch (e) {
      print(e);
    }
    return calendar;
  }

    Future<List<Calendar>> retrieveCalendars() async {
    try {
      var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted = await deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
          final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
          calendars = calendarsResult?.data;
          
        }
      }
    
    } on PlatformException catch (e) {
      print(e);
    }
      return calendars;
  }
}
