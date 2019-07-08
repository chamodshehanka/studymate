import 'package:flutter/material.dart';

final List<String> entries = <String>['8.30 - 10.30','11.00 - 12.30','13.00 - 14.30','15.00 - 16.00'];
final List<String> subjects = <String>['Mathematics','Science','English','Sinhala'];
class DailyScreen extends StatefulWidget{

  
  _DailyScreenState createState() => _DailyScreenState();
  }
  
  class _DailyScreenState extends State<DailyScreen>{
  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
      appBar: AppBar(title: Text("StudyMate - Study Schedule"),
      backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.white,
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
      body:
  ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: entries.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
          height: 50.0,
          child:
          Text('${entries[index]}',
          textAlign: TextAlign.left)
          
        );
      }, separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.blueAccent,
      ),
    )
    );
  }
    
}


class CustomListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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





