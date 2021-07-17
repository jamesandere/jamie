import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jamie/screens/landingpage/landing_helpers.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'homepage/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'Log In',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter email',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    // color: Colors.pink,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter password',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    // color: Colors.pink,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          GestureDetector(
            onTap: (){
              return showModalBottomSheet(
                context: context,
                builder: (context){
                  return Container(
                    child: Provider.of<LandingHelpers>(context, listen: false).passwordlessSignIn(context),
                  );
                }
              );
            },
            child: Container(
              child: Text(
                'Login into an Existing Account',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(emailController.text.isNotEmpty){
            Provider.of<Authentication>(context, listen: false).loginViaEmail(emailController.text, passwordController.text)
                .whenComplete(() {
              Navigator.pushReplacement(
                context,
                PageTransition(
                    child: HomePage(),
                    type: PageTransitionType.leftToRight),
              );
            });
          }
          else{
            Provider.of<LandingHelpers>(context, listen: false).warningText(context, 'Fill in the data');
          }

        },
        backgroundColor: Colors.black,
        child: Icon(
          EvaIcons.arrowForward,
        ),
      ),
    );
  }
}
