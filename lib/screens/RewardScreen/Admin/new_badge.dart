import 'package:flutter/material.dart';

class NewBadgeScreen extends StatefulWidget {
  @override
  _NewBadgeScreenState createState() => _NewBadgeScreenState();
}

class _NewBadgeScreenState extends State<NewBadgeScreen> {


  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController badgeNameCtrl = TextEditingController();
  final TextEditingController typeCtrl = TextEditingController();
  final TextEditingController milestoneCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();



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
                       child:FlatButton(
                        onPressed:() => Navigator.pushNamed(context, '/image_bank'),//popup
                        child: Icon(Icons.add,
                            size: 160.0, color: Colors.grey.shade500 
                            ),
                          ),
                  ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller:badgeNameCtrl,
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
                        controller:typeCtrl,
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
                    keyboardType: TextInputType.number,
                    controller: milestoneCtrl,
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
                        
                        
                      
                        child:Text('ADD'),
                        onPressed: () {


                          
                        },
                      ),
                    ),
                    Container(width: 15.0,),
                      Expanded(
                      child:RaisedButton(
                      child:Text('CLEAR'),
                        onPressed: () {
                          
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
}
