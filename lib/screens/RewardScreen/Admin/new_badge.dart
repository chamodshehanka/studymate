import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Badge.dart';
import 'package:studymate/services/custom/BadgeService.dart';


class NewBadgeScreen extends StatefulWidget {

  @override
  _NewBadgeScreenState createState() => _NewBadgeScreenState();
}

class _NewBadgeScreenState extends State<NewBadgeScreen> {

  List<Badge> badgeList;
  BadgeService badgeService = BadgeService();
  StreamSubscription<QuerySnapshot> badgeSubscription;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController badgeNameCtrl = TextEditingController();
  final TextEditingController typeCtrl = TextEditingController();
  final TextEditingController milestoneCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

   @override
  void initState() {
    super.initState();

    badgeList = List();
    badgeSubscription?.cancel();
    badgeSubscription =
        badgeService.getBadgeList().listen((QuerySnapshot snapshot) {
      final List<Badge> badges = snapshot.documents
          .map((documentSnapshot) => Badge.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.badgeList = badges;
      });
    });
  }

  @override
  void dispose() {
    badgeSubscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Create New Badge",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
              ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Container(
                    margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      height: 180.0,
                      width: 180.0, 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.indigo, width: 3.0),
                          right: BorderSide(color: Colors.indigo, width: 3.0),
                          left: BorderSide(color: Colors.indigo, width: 3.0),
                          bottom: BorderSide(color: Colors.indigo, width: 3.0),
                        ),
                          borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ), 
                       child:
                       FlatButton(
                        onPressed:() => Navigator.pushNamed(context, '/image_bank'),
                        child: Icon(Icons.camera,
                             color: Colors.grey.shade500 
                            ),
                          ),
                  ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    
                    keyboardType: TextInputType.text,
                    controller:badgeNameCtrl,
                    validator:(String value){
                    
                      if (value.isEmpty){
                        return 'Enter Badge Name';
     
                      }else
                      return null;
                                         
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Badge Name",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                     ),
                      
                  
                   
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: typeCtrl,
                    validator:(String value){
                    
                      if (value.isEmpty){
                        return 'Enter Badge Type';
                      }
                      return null;
                        
                      
                    },
                    
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Badge Type",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: milestoneCtrl,
                    validator:(String value){
                    
                      if (value.isEmpty){
                        return 'Enter Milestone';
                      }
                      return null;
                        
                      
                    },
                    
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Milestone",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    controller: descriptionCtrl,
                    validator:( String value){
                    
                      if (value.isEmpty){
                        return 'Enter Badge Description';

                      }
                      else
                        return null;
                      
                                              
                    },
                  
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Badge Description",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  
                 Padding(
                   padding: EdgeInsets.only(bottom: 15.0,top: 15.0,right:15.0,left:15.0),
                   child: Row(children:<Widget>
                  [
                    Expanded(
                      child:RaisedButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child:Text('ADD'),
                        onPressed: () {
                          setState(() {
                            
                             if(_formKey.currentState.validate()){
                                  _formKey.currentState.save();
                                   Future<Badge> isAdded =
                              badgeService.createBadge(badgeNameCtrl.text,typeCtrl.text,milestoneCtrl.text,descriptionCtrl.text);
                              if (isAdded != null) {
                                  Navigator.pop(context);
                                  Scaffold.of(context).showSnackBar(new SnackBar(
                                        content: new Text('Sucessfully Added!'),
                                        backgroundColor: Colors.deepPurple,
                            )); 
                             }else {
                            //Have to add error message
                            Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text('Failed to Add!'),
                              backgroundColor: Colors.deepPurple,
                            ));
                          }
                          
                              }
                          }
                          );
                        }
                      ),
                    ),
                    Container(width: 15.0,),
                      Expanded(
                      child:RaisedButton(
                      color: Colors.redAccent,
                      textColor: Colors.white,
                        child:Text('CLEAR'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    )
                  ],
                  ),
                  ),
                  
                  
                ],
              ),
            ),
          ),
        ),
      
        
      ),
    );
  }
  Future<Badge> createBadge(String name, String type,String milestone ,String description) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(badgeCollection.document());

      final Badge badge = new Badge(ds.documentID, name, type,milestone,description);
      final Map<String, dynamic> data = badge.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Badge.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }
}