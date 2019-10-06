import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Subject.dart';
import 'package:studymate/services/custom/SubjectService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class ManageSubjectScreen extends StatefulWidget {
  final Subject subject;

  ManageSubjectScreen({Key key, @required this.subject});

  @override
  _ManageSubjectScreenState createState() => _ManageSubjectScreenState();
}

class _ManageSubjectScreenState extends State<ManageSubjectScreen> {
  final SubjectService subjectService = SubjectService();

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.subject.name;
  }

  @override
  Widget build(BuildContext context) {
    // Subject Delete Action
    void subjectDeleteAction() {
      Future<dynamic> isDeleted =
          subjectService.deleteSubject(widget.subject.id);
      if (isDeleted != null) {
        Navigator.pop(context);
      } else {
        print('Subject Delete Failed');
      }
    }

    void showDeleteConfirmationDialog() {
      if (widget.subject.id != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StudymateDialogBox(
                title: 'Are you sure?',
                description: widget.subject.name +
                    ' activity will be permanently deleted!',
                confirmation: true,
                confirmationAction: subjectDeleteAction,
                tigerAnimationType: 'fail',
              );
            });
      } else {
        // showDialog<void>(
        //     context: context, child: Text('Something went wrong'));
      }
    }

    final manageSubjectBody = Container(
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
                    'Subject Name',
                    nameController,
                    'text',
                    false,
                    Colors.grey,
                    TextInputType.text,
                    Icon(Icons.local_library, color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.subject.type,
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

                          if (widget.subject.id != null) {
                            Subject updatedSubject = Subject(
                                widget.subject.id,
                                nameController.text,
                                widget.subject.type);

                            Future isUpdated =
                                subjectService.updateSubject(updatedSubject);
                            if (isUpdated != null) {
                              Navigator.pop(context);
                            }
                          } else {
                            print('Subject id is not valid');
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
          title: Text('Manage ' + widget.subject.name + ' Subject'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: manageSubjectBody,
      ),
    );
  }
}
