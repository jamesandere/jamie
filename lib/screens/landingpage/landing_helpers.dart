import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jamie/screens/homepage/home_page.dart';
import 'package:jamie/screens/landingpage/landing_utils.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:jamie/services/FirebaseOperations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingHelpers with ChangeNotifier {
  Widget passwordlessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                  children: snapshot.data.docs
                      .map((DocumentSnapshot documentSnapshot) {
                return GestureDetector(
                  onTap: (){
                    Provider.of<Authentication>(context, listen: false).loginViaEmail(
                     documentSnapshot.data()['useremail'], documentSnapshot.data()['userpassword'],
                    ).whenComplete(() {
                      Navigator.pushReplacement(context, PageTransition(child: HomePage(), type: PageTransitionType.leftToRight));
                    });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: documentSnapshot.data()['userimage'] != null ?
                          NetworkImage(documentSnapshot.data()['userimage']) : AssetImage('assets/images/emptyperson.png'),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Provider.of<FirebaseOperations>(context, listen: false).deleteUserData(
                          documentSnapshot.data()['useruid']
                        );
                      },
                      icon: Icon(
                        FontAwesomeIcons.trashAlt,
                        color: Colors.red,
                      ),
                    ),
                    subtitle: Text(
                      documentSnapshot.data()['useremail'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      documentSnapshot.data()['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList());
            }
          }),
    );
  }

  signUpSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      hintStyle: TextStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      hintStyle: TextStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: TextStyle(),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.check,
                  ),
                ),
              ],
            ),
          );
        });
  }

  loginSheet(BuildContext context) {
    return showModalBottomSheet(
        // isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      hintStyle: TextStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: TextStyle(),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.check,
                  ),
                ),
              ],
            ),
          );
        });
  }

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: Colors.pink,
                ),
              ),
              CircleAvatar(
                radius: 80.0,
                backgroundColor: Colors.transparent,
                backgroundImage: FileImage(
                  Provider.of<LandingUtils>(context, listen: false).userAvatar,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Provider.of<LandingUtils>(context, listen: false)
                            .pickUserAvatar(context, ImageSource.gallery);
                      },
                      child: Text(
                        'Reselect',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Provider.of<FirebaseOperations>(context, listen: false)
                            .uploadUserAvatar(context)
                            .whenComplete(() {
                              proceedSheet(context);
                        });
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  proceedSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You\'re good to go!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 20.0,),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: FileImage(
                  Provider.of<LandingUtils>(context, listen: false).getUserAvatar,
                ),
              ),
              FloatingActionButton(
                onPressed: (){
                  Provider.of<FirebaseOperations>(context, listen: false).updateDocument(context, {
                    'userimage' : Provider.of<LandingUtils>(context, listen: false).getUserAvatarUrl,
                  }).whenComplete(() {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: HomePage(),
                          type: PageTransitionType.leftToRight),
                    );
                  });
                },
                child: Text(
                  'Continue',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                warning,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                ),
              ),
            ),
          );
        });
  }
}
