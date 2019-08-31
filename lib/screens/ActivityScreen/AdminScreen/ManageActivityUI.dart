import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/ActivityService.dart';

class ManageActivityScreen extends StatelessWidget {
  final Activity activity;
  final ActivityService activityService = ActivityService();

  ManageActivityScreen({Key key, @required this.activity});

  @override
  Widget build(BuildContext context) {
    final manageActivityBody = Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: activity.name,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: activity.type,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.redAccent,
              child: Text('Remove'),
              onPressed: () {
                if (activity.id != null) {
                  showDialog<ConfirmAction>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Are you sure?'),
                          actions: <Widget>[
                            RaisedButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(ConfirmAction.CANCEL);
                                }),
                            RaisedButton(
                                child: Text('Accept'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(ConfirmAction.ACCEPT);
                                  activityService.deleteActivity(activity.id);
                                }),
                          ],
                        );
                      });
                } else {
                  showDialog<void>(
                      context: context, child: Text('Something went wrong'));
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Text('Save'),
              onPressed: () => {
                
              },
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(activity.name),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: manageActivityBody,
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Text(activity.type),
      // ),
    );
  }
}

enum ConfirmAction { CANCEL, ACCEPT }
