import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AuthBody extends StatefulWidget {
  AuthBody(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    String address,
    String city,
    String state,
    String contact,
    String website,
    bool isLogin,
    File pickedImage,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthBodyState createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  var _isLogin = false;
  File _profileImage;

  @override
  void dispose() {
    super.dispose();
    FirebaseAuth.instance.signOut();
  }
  // String dropdownValue = 'Andhra Pradesh';
  // List <String> spinnerItems = [
  //   "Andhra Pradesh","Arunachal Pradesh" ,"Assam",
  //    "Bihar" ,"Chhattisgarh" ,"Goa" , "Gujarat" ,"Haryana" ,"Himachal Pradesh","Jharkhand",
  //     "Karnataka","Kerala","Madhya Pradesh","Maharashtra" ,"Manipur","Meghalaya","Mizoram","Nagaland",
  //     "Odisha", "Punjab" ,"Rajasthan" ,"Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh" ,"Uttarakhand" ,"West Bengal",

  //   ] ;

  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _name = "";
  String _password = "";
  String _address="";
  String _city="";
  String _state="";
  String _mobile="";
  String _website="";

  void _pickProfileImage() async{
    final _pickedImage= await ImagePicker().getImage(source: ImageSource.gallery);
    final _pickedImageFile=File(_pickedImage.path);
    setState(() {
      _profileImage=_pickedImageFile;
    });
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_profileImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick a peofile image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_email, _name, _password,_address,_city,_state,_mobile, _website,_isLogin, _profileImage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red[100]),
      child: Center(
        child: Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if(!_isLogin)
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red[200],
                        backgroundImage: _profileImage!=null ? FileImage(_profileImage): null,
                      ),
                      SizedBox(height: 10),
                      if(!_isLogin)
                      FlatButton.icon(
                          onPressed:_pickProfileImage,
                          icon: Icon(Icons.person),
                          label: Text("Add a Profile Picture")),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (!value.contains('@') || value.isEmpty) {
                            return "Please Enter A valid Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            labelText: "Email", icon: Icon(Icons.email,color: Colors.blue,)),
                      ),
                      if (!_isLogin)
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            if (value.length < 4 || value.isEmpty) {
                              return "Username should be atleast 4 characters long";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              labelText: "Organisation Name", icon: Icon(Icons.group_add,color: Colors.blue,)),
                        ),
                      TextFormField(
                        obscureText: true,
                        onSaved: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value.length < 4 || value.isEmpty) {
                            return "Password should be atleast 4 characters Long";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            icon: Icon(Icons.lock,color: Colors.blue,), labelText: "Password"),
                      ),
                      if (!_isLogin)
                      TextFormField(
                        onSaved: (value){
                          _address=value;
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Address cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          icon:Icon(Icons.location_on,color: Colors.blue,),
                          labelText: "Enter Address"
                        ),
                      ),
                      if (!_isLogin)
                      TextFormField(
                        onSaved: (value){
                          _city=value;
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Please Enter Your City";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          icon:Icon(Icons.location_city,color: Colors.blue,),
                          labelText: "Enter City Name"
                        ),
                      ),
                      if (!_isLogin)
                      TextFormField(
                        onSaved: (value){
                          _state=value;
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Please Enter Your State";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          icon:Icon(Icons.add_location,color: Colors.blue,),
                          labelText: "Enter State Name"
                        ),
                      ),
                      if (!_isLogin)
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        onSaved: (value){
                          _mobile=value;
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Please Enter A Valid Contact Number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          icon:Icon(Icons.phone,color: Colors.blue,),
                          labelText: "Enter Mobile Number"
                        ),
                      ),
                      if (!_isLogin)
                      TextFormField(
                        keyboardType: TextInputType.url,
                        onSaved: (value){
                          _website=value;
                        },
                        validator: (value){
                          if(value.isEmpty || !value.startsWith("www.")
                          ){
                            return "Website name should start with www.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          icon:Icon(Icons.web,color: Colors.blue,),
                          labelText: "Enter Your Website(If exists)"
                        ),
                      ),
                      SizedBox(height: 10),
                      widget.isLoading ? CircularProgressIndicator(): 
                      RaisedButton(
                        onPressed: _trySubmit,
                        child: _isLogin ? Text("LogIn") : Text("SignUp"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.red[100],
                      ),
                      SizedBox(height: 5),
                      if(!widget.isLoading)
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: _isLogin
                              ? Text("New Here? SignUp",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ))
                              : Text("Existing User ? LogIn",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  )))
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
