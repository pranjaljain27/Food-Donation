import 'package:firebase_auth/firebase_auth.dart';
import 'food_details.dart';
import 'package:flutter/material.dart';


class MobileAuth extends StatelessWidget {
  
  final add;

  MobileAuth(this.add);
  
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();


  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if(user != null){
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => FoodDetails(user,add)
            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter the 6 digit OTP"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                      AuthResult result = await _auth.signInWithCredential(credential);

                      FirebaseUser user = result.user;

                      if(user != null){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => FoodDetails(user,add)
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                  SizedBox(height: 16,),

                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.grey[200])
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Mobile Number"

                      ),
                      controller: _phoneController,
                    ),
                  ),

                  SizedBox(height: 16,),


                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("Get OTP"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        final phone = _phoneController.text.trim();

                        loginUser(phone, context);

                      },
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                    
                      "** Add Country Code before the number",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
