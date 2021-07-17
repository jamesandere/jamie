import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jamie/screens/login_page.dart';
import 'package:jamie/screens/signup_page.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'landing_helpers.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          bodyColor(),
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.65,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //         'assets/images/ins.png',
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 450.0,
          //   left: 10.0,
          //   child: Row(
          //     children: [
          //       Text(
          //         'Connect',
          //         style: TextStyle(
          //           fontFamily: 'Poppins',
          //           fontSize: 40.0,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       Text(
          //         '.',
          //         style: TextStyle(
          //           color: Colors.pink,
          //           fontSize: 60.0,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Positioned(
          //   top: 570.0,
          //   left: 10.0,
          //   child: Column(
          //     children: [
          //       MaterialButton(
          //         onPressed: () {
          //           Provider.of<LandingHelpers>(context, listen: false).loginSheet(context);
          //         },
          //         elevation: 0,
          //         color: Colors.black54,
          //         child: Text(
          //           'Log In',
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       MaterialButton(
          //         onPressed: () {
          //           Provider.of<LandingHelpers>(context, listen: false).signUpSheet(context);
          //         },
          //         elevation: 0,
          //         color: Colors.black54,
          //         child: Text(
          //           'Sign Up',
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       Text(
          //         'OR',
          //       ),
          //       Row(
          //         children: [
          //           Icon(
          //             EvaIcons.google,
          //           ),
          //           Text(
          //             'Sign In with Google',
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Image.asset(
            'assets/images/social.jpg',
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black54,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Share Your\nHappy Moments',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      'Join to discover and meet new people\nAnd live your best life .',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height:  50.0,),
                    MaterialButton(
                      onPressed: (){
                        // Provider.of<LandingHelpers>(context, listen: false).signUpSheet(context);
                        Navigator.pushReplacement(context, PageTransition(child: SignUp(), type: PageTransitionType.leftToRight));
                      },
                      color: Colors.white,
                      minWidth: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Sign up with email',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    MaterialButton(
                      onPressed: (){},
                      color: Color(0xFF395697),
                      minWidth: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                            size: 14.0,
                          ),
                          SizedBox(width: 8.0,),
                          Text(
                            'Continue with Facebook',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    MaterialButton(
                      onPressed: (){
                        Provider.of<Authentication>(context, listen: false).signInWithGoogle();
                      },
                      color: Colors.white,
                      minWidth: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset('assets/images/google.png',height: 20.0, width: 40.0,),
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                            size: 14.0,
                          ),
                          SizedBox(width: 8.0,),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, PageTransition(child: Login(), type: PageTransitionType.leftToRight));
                      },
                      child: Container(
                        child: RichText(
                          text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,

                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Log In',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 80.0,),
                    Text(
                      'Terms & Conditions Policies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bodyColor() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 0.9],
          colors: [
            Color(0xFFE0DFE1),
            Color(0xFFEEEDEF),
          ],
        ),
      ),
    );
  }
}
