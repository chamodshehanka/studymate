import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class ManageActivityScreen extends StatefulWidget {
  final Activity activity;

  ManageActivityScreen({Key key, @required this.activity});

  @override
  _ManageActivityScreenState createState() => _ManageActivityScreenState();
}

class _ManageActivityScreenState extends State<ManageActivityScreen> {
  final ActivityService activityService = ActivityService();

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.activity.name;
  }

  @override
  Widget build(BuildContext context) {
    // Activity Delete Action
    void activityDeleteAction() {
      Future<dynamic> isDeleted =
          activityService.deleteActivity(widget.activity.id);
      if (isDeleted != null) {
        Navigator.pop(context);
      } else {
        print('Activity Delete Failed');
      }
    }

    void showDeleteConfirmationDialog() {
      if (widget.activity.id != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StudymateDialogBox(
                title: 'Are you sure?',
                description: widget.activity.name +
                    ' activity will be permanently deleted!',
                confirmation: true,
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
                child: StudymateTextField(
                    'Activity Name',
                    nameController,
                    'text',
                    false,
                    Colors.grey,
                    TextInputType.text,
                    Icon(Icons.local_activity, color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.activity.type,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          if (widget.activity.id != null) {
                            Activity updatedActivity = Activity(
                                widget.activity.id,
                                nameController.text,
                                widget.activity.type);

                            Future isUpdated =
                                activityService.updateActivity(updatedActivity);
                            if (isUpdated != null) {
                              Navigator.pop(context);
                            }
                          } else {
                            print('Activity id is not valid');
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text('Remove'),
                      onPressed: showDeleteConfirmationDialog,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage ' + widget.activity.name + ' Activity'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: manageActivityBody,
      ),
    );
  }
}
