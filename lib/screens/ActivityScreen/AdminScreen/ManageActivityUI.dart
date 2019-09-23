import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';

class ManageActivityScreen extends StatelessWidget {
  final Activity activity;
  final ActivityService activityService = ActivityService();
  final _formKey = GlobalKey<FormState>();
  final nameController;

  ManageActivityScreen({Key key, @required this.activity, this.nameController});

  @override
  Widget build(BuildContext context) {
    // Activity Delete Action
    void activityDeleteAction() {
      Future<dynamic> isDeleted = activityService.deleteActivity(activity.id);
      if (isDeleted != null) {
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Successfully Deleted!"),
          backgroundColor: Colors.deepPurple,
        ));
        Navigator.pop(context);
      } else {}
    }

    void showDeleteConfirmationDialog() {
      if (activity.id != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StudymateDialogBox(
                title: 'Are you sure?',
                description:
                    activity.name + ' activity will be permanently deleted!',
                confirmation: true,
                buttonText: 'No',
                confirmationAction: activityDeleteAction,
                tigerAnimationType: 'fail',
              );
            });
      } else {
        // showDialog<void>(
        //     context: context, child: Text('Something went wrong'));
      }
    }

    final manageActivityBody = Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Activity Name"),
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter activity name';
                    } else {
                      return null;
                    }
                  },
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
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      if (activity.id != null) {
                        Activity updatedActivity = Activity(
                            activity.id, nameController.text, activity.type);
                        print(activity.id);
                        print(nameController.text);
                        Future isUpdated =
                            activityService.updateActivity(updatedActivity);
                        if (isUpdated != null) {
                          Navigator.pop(context);
                        }
                      } else {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('Activity ID is not valid!'),
                          backgroundColor: Colors.deepPurple,
                        ));
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: Text('Remove'),
                  onPressed: showDeleteConfirmationDialog,
                ),
              ),
            ],
          )),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(activity.name),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: manageActivityBody,
      ),
    );
  }
}
