import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddonation/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/request_placed.dart';


class FoodDetails extends StatefulWidget {

  final FirebaseUser user;
  final String add;
  FoodDetails(this.user,this.add);

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {

  bool _savingData=false;
  final _formKey = GlobalKey<FormState>();
  var _nameController=TextEditingController();
  var _pickupAddress=TextEditingController();
  var _foodData=TextEditingController();
  var _phoneController=TextEditingController();


  @override
  void dispose() {
    super.dispose();
    FirebaseAuth.instance.signOut();
  }

  void _sendReq() async{
    if(_formKey.currentState.validate()==false)
    {
      _savingData=false;
      return;
    }
    await Firestore.instance.collection("request").add({
      "orgAdd":widget.add,
      "rName":_nameController.text,
      "rPhone":_phoneController.text,
      "rAdd":_pickupAddress.text,
      "rData":_foodData.text,
      "created":Timestamp.now(),
      "read":false
    });
    _savingData=false;
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RequestPlaced()));
  }
  @override
  Widget build(BuildContext context) {
    _phoneController.text=widget.user.phoneNumber;
    return new WillPopScope(
      onWillPop:  () async => false,
          child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.red[50]
          ),
          padding: EdgeInsets.all(32),
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Request Pickup",style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,fontStyle: FontStyle.italic
                      ),),
                      SizedBox(height:30),
                      Form(
                        key: _formKey,
                          child: SingleChildScrollView(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: TextFormField(
                                  
                                  validator: (val){
                                    if(val.isEmpty){
                                      return "Please Enter Your Name";
                                    }
                                    return null;
                                  },                        
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    hintText: "Enter Your Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    )
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  labelText: "Contact",
                                  hintText: "Enter Contact Details",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  
                                  )
                                ),
                                validator: (val){
                                  if(val.isEmpty){
                                    return "Please Enter Contact Number";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height:10),
                              TextFormField(
                                controller: _pickupAddress,
                                validator: (val){
                                  if(val.isEmpty){
                                    return "Please Enter Pickup Address";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Pickup Address",
                                  labelText: "Address",
                                ),
                              ),
                              SizedBox(height:10),
                              TextFormField(
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: "Enter Food Details",
                                  labelText: "Food Details",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                ),
                                controller: _foodData,
                                validator: (val){
                                  if(val.isEmpty){
                                  return "Please Enter The Food Details(includes quantity and food items)";
                                  }
                                  return null;
                                }
                              ),
                              SizedBox(height:10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _savingData? CircularProgressIndicator():
                                  FlatButton(
                                    color: Colors.red[100],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                    ,onPressed:(){
                                      setState(() {
                                        _savingData=true;
                                      });
                                      _sendReq();
                                    }
                                    , child: Text("Place Request")),
                                  if(!_savingData)FlatButton(
                                    color: Colors.red[100],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                    ,onPressed: (){
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
                                  }, child: Text("Cancel")),
                                ],
                              )
                          ],
                        ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}