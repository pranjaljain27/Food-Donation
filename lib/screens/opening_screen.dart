import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'main_screen.dart';

class OpeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image:AssetImage("lib/assets/images/drivefood.jpg",),fit: BoxFit.fitWidth),),
        child: Column(
          children: <Widget>[
            Container(
              height: 45,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,left:10,right: 20),
              child: Text(
                "Food Donation",
                style: TextStyle(
                  fontSize: 35,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.6
                ,left:10,right:10),
                height: 60,
                width: double.infinity,
                child: FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.greenAccent,
                      width:3,
                      style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => AuthScreen()));
                  },
                  child: Text(
                    "We Are An Organisation",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,                            
                    ),
                  ),
          
                )),
            Container( 
              margin: EdgeInsets.only(
                top:10,
                left:10,right:10),                                    
                height: 60,
                width: double.infinity,                               
                child: FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.greenAccent,
                      width:3,
                      style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => MainScreen()));
                  },
                  child: Text(
                    "I am a Donor",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  
                )),
          ],
        ),
      ),
    );
  }
}
