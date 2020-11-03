import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddonation/screens/dashboard_screen.dart';
import '../widgets/auth_body.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  var _isLoading=false;
  final _auth = FirebaseAuth.instance;

  void _submitData(
    String email,
    String name,
    String password,
    String address,
    String city,
    String state,
    String contact,
    String website,
    var isLogin,
    File profileImage,
    BuildContext ctx,
  ) async {
    AuthResult authresult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
            _isLoading=false;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>DashboardScreen()));
      } else {
        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('profile')
            .child(authresult.user.uid + '.jpeg');

        await ref.putFile(profileImage).onComplete;
        final url = await ref.getDownloadURL();

        await Firestore.instance
            .collection("users")
            .document(authresult.user.uid)
            .setData({
          'email': email,
          'orgname': name,
          'profile': url,
          'address':address,
          'city':city,
          'state':state,
          'contact':contact,
          'website':website
        });
        _isLoading=false;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>DashboardScreen()));
      }
    } on PlatformException catch (err) {
      setState(() {
        _isLoading = false;
      });
      var message = "An error Occurred";

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      var message = "An error Occurred";
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:AuthBody(_submitData,_isLoading)
    );
  }
}