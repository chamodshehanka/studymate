import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{

  
  _HomeScreenState createState() => _HomeScreenState();
  }
  
  class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text("StudyMate"),
      backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.blueAccent,
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Icon(
                Icons.account_circle,
                size: 90.0,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.orangeAccent,
                  Colors.yellow,
                ])
              ),
            ),
         CustomListTile(Icons.person,'Profile',()=>{}),
            CustomListTile(Icons.note,'Reminders',()=>{}),
            CustomListTile(Icons.info, 'About Us', ()=>{}),
            CustomListTile(Icons.settings,'Settings',()=>{}),
            CustomListTile(Icons.exit_to_app,'Logout',()=>{}),
          ],
        ),
      ),
      body:GridView.count(
primary: false,
  padding: const EdgeInsets.all(20.0),
  crossAxisSpacing: 10.0,
  crossAxisCount: 2,
  children: <Widget>[

       Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
           child:FlatButton(
              onPressed:()=>
                Navigator.pushNamed(context, '/daily'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                  Icons.calendar_today,
                  color:Colors.blueGrey,
                  size:70.0,
                  ),
                  Text(
                  "Daily Schedule",
                  style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.none,
                          fontSize: 17.0,
                          fontFamily: "OpenSans",
                  ),
                  ),
                ],
              )
              
            ),
          ),
        ),
      ),

        Card(
      
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
            child:FlatButton(
              onPressed:()=>{},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                  Icons.timeline,
                  color:Colors.blueGrey,
                  size:70.0,
                  ),
                  Text(
                  "Progress Tracking",
                  style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.none,
                          fontSize: 17.0,
                          fontFamily: "OpenSans",
                  ),
                  ),
                ],
              )
              
            ),
          ),
        ),
      ),

        Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
            child:FlatButton(
              onPressed:()=>{},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                  Icons.book,
                  color:Colors.blueGrey,
                  size:70.0,
                  ),
                  Text(
                  "Subject Manager",
                  style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          fontFamily: "OpenSans",
                  ),
                  ),
                ],
              )
              
            ),
          ),
        ),
      ),

        Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
            child:FlatButton(
              onPressed:()=>{},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                  Icons.games,
                  color:Colors.blueGrey,
                  size:70.0,
                  ),
                  Text(
                  "Activity Manager",
                  style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          fontFamily: "OpenSans",
                  ),
                  ),
                ],
              )
              
            ),
          ),
        ),
      ),

        Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
            child:FlatButton(
              onPressed:()=>{},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                  Icons.calendar_today,
                  color:Colors.blueGrey,
                  size:70.0,
                  ),
                  Text(
                  "Weekly Schedule",
                  style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          fontFamily: "OpenSans",
                  ),
                  ),
                ],
              )
              
            ),
          ),
        ),
      ),

        Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
            child:FlatButton(
              onPressed:()=>{},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                  Icons.supervised_user_circle,
                  color:Colors.blueGrey,
                  size:70.0,
                  ),
                  Text(
                  "Profile",
                  style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          fontFamily: "OpenSans",
                  ),
                  ),
                ],
              )
              
            ),
          ),
        ),
      ),
  ],
      )
    );
  }
    
}




class CustomListTile extends StatelessWidget{

  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding( 
    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
    child:InkWell(
      splashColor: Colors.orangeAccent,
      onTap: onTap,
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children:<Widget>[
            Icon(icon),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text,style:TextStyle(
                fontSize: 16.0
              )),
            ),
              ]
         
            ),
            Icon(Icons.arrow_right)
          ],
            
        ),
      ),
    )
    );
  }
    
}







