import 'package:flutter/material.dart';
import 'opening_screen.dart';

class RequestPlaced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height:100,
                width: 100,
                child: Image.asset("lib/assets/images/checked.png"),
              ),
              Text("Your Pickup Request Has Been Successfully Placed",style: TextStyle(
                color: Colors.blue,fontSize: 35,fontStyle: FontStyle.italic,
              ),softWrap: true,),
              SizedBox(height: 20,),
              Text("* The Organisation will contact you soon !",style: TextStyle(
                fontSize: 20,
              ),softWrap: true,),
              SizedBox(height: 30,),
              FlatButton.icon(icon:Icon(Icons.exit_to_app,size: 30,),onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>OpeningScreen()));
              }, 
              label: Text("Close",style: TextStyle(fontSize: 22),)),
              SizedBox(height:30),
            
            ],
          ),
        ),
      )
    );
  }
}