import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jamie/screens/landingpage/landing_helpers.dart';
import 'package:jamie/screens/landingpage/landing_utils.dart';
import 'package:jamie/screens/landingpage/profile_picture_page.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:jamie/services/FirebaseOperations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
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
            'Signup',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter username',
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
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
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(emailController.text.isNotEmpty){
            Provider.of<Authentication>(context, listen: false).createAccount(emailController.text, passwordController.text).whenComplete(() {
              Provider.of<FirebaseOperations>(context, listen: false).createUserCollection(context, {
                'userpassword' : passwordController.text,
                'useruid' : Provider.of<Authentication>(context, listen: false).getUserUid,
                'useremail' : emailController.text,
                'username' : usernameController.text,
                // 'userimage' : Provider.of<LandingUtils>(context, listen: false).getUserAvatarUrl,
              });
            })
            .whenComplete(() {
              Navigator.pushReplacement(context, PageTransition(child: ProfilePic(), type: PageTransitionType.leftToRight));
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
