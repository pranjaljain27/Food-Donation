import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  final picture;
  final name;
  final mail;
  final address;
  final city;
  final state;
  final contact;
  final website;

  EditProfile(
      this.picture, this.name, this.mail, this.address, this.city, this.state,this.contact,this.website);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _isLoading = false;
  var _nameController = TextEditingController();
  var _mailController = TextEditingController();
  var _addressController = TextEditingController();
  var _cityController = TextEditingController();
  var _stateController = TextEditingController();
  var _contactController=TextEditingController();
  var _webController=TextEditingController();

  void _updateData() async {
    setState(() {
      _isLoading = true;
    });
    var currentUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .updateData({
      "orgname": _nameController.text,
      "email": _mailController.text,
      "address": _addressController.text,
      "city": _cityController.text,
      "state": _stateController.text,
      "contact":_contactController.text,
      "website":_webController.text
    });
    _isLoading=false;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.name;
    _mailController.text = widget.mail;
    _addressController.text = widget.address;
    _cityController.text = widget.city;
    _stateController.text = widget.state;
    _contactController.text=widget.contact;
    _webController.text=widget.website;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Profile"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.yellow,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(widget.picture),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "Organisation Name",
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _mailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "Address",
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "City",
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _stateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "State",
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _contactController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "Contact",
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _webController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "Website",
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple, width: 1)),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : FlatButton.icon(
                        onPressed: _updateData,
                        icon: Icon(Icons.save),
                        label: Text("Save Changes",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              color: Colors.blue,
                            )),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
