import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studymate/models/Task.dart';
import 'package:studymate/services/custom/AppointmentService.dart';

class TaskScreen extends StatefulWidget {
  final Task task;
  TaskScreen(this.task);
  @override

  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  AppointmentService fireServ = new AppointmentService();

  TextEditingController _taskappointmentIDController;
  TextEditingController _taskNameController;
  TextEditingController _taskSpecialDescriptionController;
  TextEditingController _taskDateController;
  TextEditingController _taskTimeController;
  TextEditingController _taskplaceController;

  final _formKey = GlobalKey<FormState>();
  void validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(
          'Form is Valid.taskappointmentID:$_taskappointmentIDController,taskname:$_taskNameController,taskSpecialDescription: $_taskSpecialDescriptionController,taskdate: $_taskDateController,taskTime: $_taskTimeController, taskplace: $_taskplaceController');
    } else {
      print(
          'Form is Invalid.taskappointmentID:$_taskappointmentIDController,taskname:$_taskNameController,taskSpecialDescription: $_taskSpecialDescriptionController,taskdate: $_taskDateController,taskTime: $_taskTimeController, taskplace: $_taskplaceController');
    }
  }

  @override
  void initState() {
    super.initState();



    _taskappointmentIDController =
        new TextEditingController(text: widget.task.taskappointmentID);
    _taskNameController = new TextEditingController(text: widget.task.taskname);
    _taskSpecialDescriptionController =
        new TextEditingController(text: widget.task.taskSpecialDescription);
    _taskDateController = new TextEditingController(text: widget.task.taskdate);
    _taskTimeController = new TextEditingController(text: widget.task.tasktime);
    _taskplaceController =
        new TextEditingController(text: widget.task.taskplace);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
            key: _formKey,
            child: new SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _myAppBar(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 60,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 14.0, right: 14.0),
                          child: TextFormField(
                              controller: _taskappointmentIDController,
                              decoration: InputDecoration(
                                  labelText: "Appointment ID ",
                                  prefixIcon: Icon(Icons.assignment)),
                              onSaved: (value) => _taskappointmentIDController =
                                  value as TextEditingController,
                              validator: (value) => value.isEmpty
                                  ? 'Appointment ID can\'t be empty'
                                  : null),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 14.0, right: 14.0),
                          child: TextFormField(
                              controller: _taskNameController,
                              decoration: InputDecoration(
                                  labelText: "Patient Name ",
                                  prefixIcon: Icon(Icons.account_circle)),
                              onSaved: (value) => _taskNameController =
                                  value as TextEditingController,
                              validator: (value) => value.isEmpty
                                  ? 'Patient Name can\'t be empty'
                                  : null),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 17.0, right: 17.0),
                          child: TextFormField(
                              controller: _taskSpecialDescriptionController,
                              decoration: InputDecoration(
                                  labelText: "Special Description ",
                                  prefixIcon: Icon(Icons.assignment)),
                              onSaved: (value) =>
                                  _taskSpecialDescriptionController =
                                      value as TextEditingController,
                              validator: (value) => value.isEmpty
                                  ? 'Description can\'t be empty'
                                  : null),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 14.0, right: 14.0),
                          child: TextFormField(
                              controller: _taskDateController,
                              decoration: InputDecoration(
                                  labelText: "Date ",
                                  prefixIcon: Icon(Icons.calendar_today)),
                              onSaved: (value) => _taskDateController =
                                  value as TextEditingController,
                              validator: (value) => value.isEmpty
                                  ? 'Date can\'t be empty'
                                  : null),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 14.0, right: 14.0),
                          child: TextFormField(
                              controller: _taskTimeController,
                              decoration: InputDecoration(
                                  labelText: "Time ",
                                  prefixIcon: Icon(Icons.access_time)),
                              onSaved: (value) => _taskTimeController =
                                  value as TextEditingController,
                              validator: (value) => value.isEmpty
                                  ? 'Time can\'t be empty'
                                  : null),
                        ),
                         
                        Padding(
                          padding: EdgeInsets.only(left: 14.0, right: 14.0),
                          child: TextFormField(
                              controller: _taskplaceController,
                              decoration: InputDecoration(
                                  labelText: "Place ",
                                  prefixIcon: Icon(Icons.edit_location)),
                              onSaved: (value) => _taskplaceController =
                                  value as TextEditingController,
                              validator: (value) => value.isEmpty
                                  ? 'Place can\'t be empty'
                                  : null),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                                color: Color(0xFFD50000),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Color(0xFFFAFAFA)),
                                )),
                            // This button results in adding the contact to the database
                            RaisedButton(
                                color: Color(0xFF4CAF50),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    fireServ
                                        .createTODOTask(
                                            _taskappointmentIDController.text,
                                            _taskNameController.text,
                                            _taskSpecialDescriptionController
                                                .text,
                                            _taskDateController.text,
                                            _taskTimeController.text,
                                            _taskplaceController.text)
                                        .then((_) {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(color: Color(0xFFFAFAFA)),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _myAppBar() {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
           colors: [
              const Color(0xFF6A1B9A),
              const Color(0xFF6A1B9A),
            ],
           ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Add New Appointment',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
