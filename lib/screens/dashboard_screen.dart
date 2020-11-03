import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddonation/screens/opening_screen.dart';
import 'edit_profile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'request_screen.dart';
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

   var userId;  
  var doc;
  Future<Map<String,dynamic>> _fetchData() async{
    var currentuser=await FirebaseAuth.instance.currentUser();
    userId=currentuser.uid;
    var dataSet=await Firestore.instance.collection("users").document(userId).get();
    return dataSet.data;
  }
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
    child: Scaffold(
      appBar: AppBar(
        title:Text("Dashboard"),
        actions: <Widget>[
          DropdownButton(icon: Icon(Icons.more_vert,color: Colors.white,),
          items: [
           DropdownMenuItem(
              value: "request",
              child: Row(
              children: <Widget>[
                Icon(AntDesign.car),
                SizedBox(width:5),
                Text("Pickup Request")
              ],
            )),
            DropdownMenuItem(
              value: "logout",
              child: Row(
              children: <Widget>[
                Icon(Icons.exit_to_app),
                SizedBox(width:5),
                Text("Logout")
              ],
            ))
          ], 
          onChanged: (itemIdentifier){
            if(itemIdentifier=="logout"){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>OpeningScreen()));
            }
            if(itemIdentifier=="request"){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>RequestScreen(doc['address'])));
            }
          })
        ],
      ),
      body:SingleChildScrollView(
      child: FutureBuilder(
        future:  _fetchData(),
        builder: (ctx,futureSnapshot){
          if(futureSnapshot.connectionState==ConnectionState.waiting){
                  return Center(child : CircularProgressIndicator());
                }
          return StreamBuilder(
            stream: Firestore.instance.collection("users").document(userId).snapshots()
            ,builder: (ctx,dataSnapshot){
              if(dataSnapshot.data==null){
              return Center(child: CircularProgressIndicator());
            }
            doc=dataSnapshot.data;
            return Container(
            margin: EdgeInsets.all(10),
            child:Column(children: <Widget>[
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.red[100],width: 2)),
                  width: double.infinity,
                  child:Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 60,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(doc['profile']),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(height:2),
                        Text(doc['orgname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),overflow: TextOverflow.fade,softWrap: true,),
                         SizedBox(height:2),
                         Text(doc['email'],style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),overflow: TextOverflow.fade,softWrap: true,),
                         SizedBox(height: 2,),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.red[100],width: 2)),
                             child: FlatButton.icon(onPressed: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EditProfile(
                                doc['profile'],
                              doc['orgname'],
                               doc['email'],
                               doc['address'],
                               doc['city'],
                               doc['state'],
                               doc['contact'],
                               doc['website']
                               )));
                             }, icon: Icon(Icons.edit), label: Text("Edit Profile")),
                           ),
                         )
                      ],
                    ),
                ),
                SizedBox(height:20),
                 Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.red[100],width: 2)),
                  width: double.infinity,
                   child: Column(
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:10,left:10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,color: Colors.purple,),
                          SizedBox(width: 10,),
                          Text("Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(right:10,left:10.0),
                      child: Text(doc['address'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(top:10,left:10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_city,color: Colors.purple),
                          SizedBox(width:10),
                          Text("City",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(right:10,left:10.0),
                      child: Text(doc['city'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
                    ),
                     SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(top:10,left:10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add_location,color:Colors.purple),
                          SizedBox(width:10),
                          Text("State",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(right:10,left:10.0),
                      child: Text(doc['state'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
                    ),
                     SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(top:10,left:10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.phone,color: Colors.purple),
                          SizedBox(width:10),
                          Text("Phone",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(top:10,left:10.0),
                      child: Text(doc['contact'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(top:10,left:10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.web,color: Colors.purple),
                          SizedBox(width:10),
                          Text("Website",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10,right:10,left:10.0),
                      child: Text(doc['website'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
                    ),
                ],
                ),
                 ),
            ],)
          );
            });
        },
     ), ),)
      );
    }
}