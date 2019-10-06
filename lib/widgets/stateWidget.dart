// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:studymate/models/Student.dart';
// import 'package:studymate/models/settings.dart';
// import 'package:studymate/models/state.dart';
// import 'package:studymate/services/Authentication.dart';
// import 'package:studymate/services/custom/StudentService.dart';

// class StateWidget extends StatefulWidget {
//   final StateModel state;
//   final Widget child;

//   StateWidget({
//     @required this.child,
//     this.state,
//   });

  
//   static _StateWidgetState of(BuildContext context) {
//     return (context.inheritFromWidgetOfExactType(_StateDataWidget)
//             as _StateDataWidget)
//         .data;
//   }

//   @override
//   _StateWidgetState createState() => new _StateWidgetState();
// }

// class _StateWidgetState extends State<StateWidget> {
//   StateModel state;
  

//   @override
//   void initState() {
//     super.initState();
//     if (widget.state != null) {
//       state = widget.state;
//     } else {
//       state = new StateModel(isLoading: true);
//       initUser();
//     }
//   }

//   Future<Null> initUser() async {
    
//     FirebaseAuth firebaseUserAuth = await getUserFirestore().getByID;
//     Student student = await Authentication.forgotPasswordEmail();
//     //Settings settings = await Authentication.getSettingsLocal();
//     setState(() {
//       state.isLoading = false;
//       state.firebaseUserAuth = firebaseUserAuth;
//       state.student = student; 
//      // state.settings = settings;
//     });
//   }

//   Future<void> logOutUser() async {
//     await Authentication.signOut();
//     FirebaseUser firebaseUserAuth = await Authentication.getCurrentUser();
//     setState(() {
//       state.student = null;
//       state.settings = null;
//       state.firebaseUserAuth = firebaseUserAuth;
//     });
//   }

//   Future<void> logInUser(email, password) async {
//     String user = await Authentication.signIn(email, password);
//     Student student = await Authentication.getUserFirestore(userId);
//     await Authentication.storeUserLocal(user);
//     Settings settings = await Authentication.getSettingsFirestore(userId);
//     await Authentication.storeSettingsLocal(settings);
//     await initUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new _StateDataWidget(
//       data: this,
//       child: widget.child,
//     );
//   }
// }

// class _StateDataWidget extends InheritedWidget {
//   final _StateWidgetState data;

//   _StateDataWidget({
//     Key key,
//     @required Widget child,
//     @required this.data,
//   }) : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(_StateDataWidget old) => true;
// }
