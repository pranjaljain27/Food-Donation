// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Practice extends StatefulWidget {
//   @override
//   _PracticeState createState() => _PracticeState();
// }



// class _PracticeState extends State<Practice> {

//   var userId;

//  Future<Map<String,dynamic>> _fetchData() async{
//     var currentuser=await FirebaseAuth.instance.currentUser();
//     userId=currentuser.uid;
//     var dataSet=await Firestore.instance.collection("users").document(userId).get();
//     return dataSet.data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: FutureBuilder(
//         future:  _fetchData()
//         ,
//         builder: (ctx,futureSnapshot){
//           if(futureSnapshot.connectionState==ConnectionState.waiting){
//                   return Center(child : CircularProgressIndicator());
//                 }
//           return StreamBuilder(
//             stream: Firestore.instance.collection("users").document(userId).snapshots()
//             ,builder: (ctx,dataSnapshot){
//               if(dataSnapshot.data==null){
//               return Center(child: CircularProgressIndicator());
//             }
//             final doc=dataSnapshot.data;
//             return Container(
//             margin: EdgeInsets.all(10),
//             child:Column(children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.red[100],width: 2)),
//                   width: double.infinity,
//                   child:Column(
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: Colors.yellow,
//                           radius: 60,
//                           child: CircleAvatar(
//                             radius: 55,
//                             backgroundImage: NetworkImage(doc['profile']),
//                             backgroundColor: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height:2),
//                         Text(doc['orgname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),overflow: TextOverflow.fade,softWrap: true,),
//                          SizedBox(height:2),
//                          Text(doc['email'],style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),overflow: TextOverflow.fade,softWrap: true,),
//                          SizedBox(height: 2,),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Container(
//                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.red[100],width: 2)),
//                              child: FlatButton.icon(onPressed: (){
//                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EditProfile(
          
//                                 doc['profile'],
//                               doc['orgname'],
//                                doc['email'],
//                                doc['address'],
//                                doc['city'],
//                                doc['state']
//                                )));
//                              }, icon: Icon(Icons.edit), label: Text("Edit Profile")),
//                            ),
//                          )
//                       ],
//                     ),
//                 ),
//                 SizedBox(height:20),
//                  Container(
//                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.red[100],width: 2)),
//                   width: double.infinity,
//                    child: Column(
//                 children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(top:10,left:10.0),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.location_on,color: Colors.purple,),
//                           SizedBox(width: 10,),
//                           Text("Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 5,),
//                     Padding(
//                       padding: const EdgeInsets.only(right:10,left:10.0),
//                       child: Text(doc['address'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
//                     ),
//                     SizedBox(height: 20,),
//                     Padding(
//                       padding: const EdgeInsets.only(top:10,left:10.0),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.location_city,color: Colors.purple),
//                           SizedBox(width:10),
//                           Text("City",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 5,),
//                     Padding(
//                       padding: const EdgeInsets.only(right:10,left:10.0),
//                       child: Text(doc['city'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
//                     ),
//                      SizedBox(height: 20,),
//                     Padding(
//                       padding: const EdgeInsets.only(top:10,left:10.0),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.add_location,color:Colors.purple),
//                           SizedBox(width:10),
//                           Text("State",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 5,),
//                     Padding(
//                       padding: const EdgeInsets.only(right:10,left:10.0),
//                       child: Text(doc['state'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
//                     ),
//                      SizedBox(height: 20,),
//                     Padding(
//                       padding: const EdgeInsets.only(top:10,left:10.0),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.phone,color: Colors.purple),
//                           SizedBox(width:10),
//                           Text("Phone",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 5,),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10,right:10,left:10.0),
//                       child: Text(doc['contact'],softWrap: true,overflow: TextOverflow.fade,maxLines: 2,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic)),
//                     ),
//                 ],
//                 ),
//                  ),
//             ],)
//           );
//             });
//         },
//      ), );
//   }
// }