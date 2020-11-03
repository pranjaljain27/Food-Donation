import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/calls_messages.dart';
import '../services/service_locator.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestScreen extends StatefulWidget {

  final add;
  RequestScreen(this.add);
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final CallsAndMessages _service = locator<CallsAndMessages>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
      ),
      body: FutureBuilder(
            future: FirebaseAuth.instance.currentUser()
            ,builder: (ctx,futureSnapshot){
              if(futureSnapshot.connectionState==ConnectionState.waiting){
                return Center(child:CircularProgressIndicator());
              }
              return StreamBuilder(
                stream: Firestore.instance.collection("request").orderBy('created',descending: true).where('orgAdd',isEqualTo: widget.add).snapshots()
                ,builder: (ctx,dataSnapshot){
                  if(dataSnapshot.data==null){
                    return Center(child: Text("No Request Recieved"),);
                  }
                  final doc=dataSnapshot.data.documents;
                  return ListView.builder(
                            shrinkWrap: true,
                          itemCount: doc.length
                          ,itemBuilder: (ctx,index){
                            return Card
                            (
                                elevation: 5,
                                color: Colors.red[50],
                                  margin: EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                 child: Container(
                                child: Padding(padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    SizedBox(height: 5,),
                                    Text(doc[index]['rName'],softWrap: true,),
                                    SizedBox(height:15),
                                    Text("Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    SizedBox(height: 5,),
                                    Text(doc[index]['rAdd'],softWrap: true,),
                                    SizedBox(height:15),
                                    Text("Contact",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    SizedBox(height: 5,),
                                    Text(doc[index]['rPhone'],softWrap: true,),
                                    SizedBox(height:15),
                                    Text("Food Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    SizedBox(height: 5,),
                                    Text(doc[index]['rData'],softWrap: true,),
                                    SizedBox(height:15),
                                    Text("Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    SizedBox(height: 5,),
                                    Text(timeago.format(doc[index]['created'].toDate()),softWrap: true,),
                                    SizedBox(height:5),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: doc[index]['read'] ?Image.asset("lib/assets/images/checked.png"):null,
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center
                                      ,children: <Widget>[
                                       FlatButton(
                                         
                                         onPressed: (){
                                            _service
                                          .call(doc[index]['rPhone']);
                                         },
                                        child: Text("Call Donor",style: TextStyle(fontSize: 20),),
                                        color: Colors.yellow,),
                                    ],)
                                  ],
                                ),),
                              ),
                            );
                          });
                  
                    
                });
            }),
      
      
    );
  }
}