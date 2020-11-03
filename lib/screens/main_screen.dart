import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/calls_messages.dart';
import '../services/service_locator.dart';
import '../screens/mobile_auth.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CallsAndMessages _service = locator<CallsAndMessages>();
  List<Map<String, dynamic>> initialList = List();

  List<Map<String, dynamic>> filteredList = List();


    
Future<void> _launchURL(String newurl) async {
  var url = newurl;
  if (await canLaunch(url)) {
    launch(url,forceWebView: true,enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("users")
        .getDocuments()
        .then((querySnapshots) {
      querySnapshots.documents.forEach((orgn) {
        initialList.add(orgn.data);
      });
      setState(() {
        filteredList = initialList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Donation"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  filteredList = initialList
                      .where((element) => (element['orgname']
                              .toString()
                              .toLowerCase()
                              .contains(val.toLowerCase()) ||
                          element['address']
                              .toString()
                              .toLowerCase()
                              .contains(val.toLowerCase()) ||
                          element['city']
                              .toString()
                              .toLowerCase()
                              .contains(val.toLowerCase()) ||
                          element['state']
                              .toString()
                              .toLowerCase()
                              .contains(val.toLowerCase())))
                      .toList();
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  contentPadding: EdgeInsets.only(left: 25),
                  hintText: "Find a charity near you",
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                    child:Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.purple,
                              backgroundImage:
                                  NetworkImage(filteredList[index]['profile']),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.group_add,
                                  color: Colors.purple,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  filteredList[index]['orgname'],
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.email,
                                  color: Colors.purple,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  filteredList[index]['email'],
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  color: Colors.purple,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  filteredList[index]['contact'],
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.purple,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  filteredList[index]['address'],
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_city,
                                  color: Colors.purple,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  filteredList[index]['city'],
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add_location,
                                  color: Colors.purple,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  filteredList[index]['state'],
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton.icon(
                                    onPressed: () {
                                      _service
                                          .call(filteredList[index]['contact']);
                                    },
                                    color: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    icon: Icon(Icons.call),
                                    label: Text("Call Now")),
                                FlatButton.icon(
                                  onPressed: () {
                                    _service
                                        .sendEmail(filteredList[index]['email']);
                                  },
                                  icon: Icon(Icons.mail_outline),
                                  label: Text("Email Now"),
                                  color: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              child: filteredList[index]['website'] == ""
                                  ? Text("Website Not Available")
                                  : FlatButton(
                                      color: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {
                                        _launchURL(filteredList[index]['website']);
                                      },
                                      child: Text(
                                        "Go To Website",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      )),
                            ),
                            Container(
                              child: Text("OR",style: TextStyle(
                                fontSize: 20,fontStyle: FontStyle.italic
                              ),),
                            ),
                            Container(
                                      child:FlatButton(
                                      color: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MobileAuth(filteredList[index]['address'])));
                                      },
                                      child: Text(
                                        "Request Food Pickup",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      )),
                            )
                          ],
                        ),
                      ),
                    
                  );
                }),
          )
        ],
      ),
    );
  }
}
