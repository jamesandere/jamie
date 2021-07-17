import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jamie/screens/landingpage/landing_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
      Duration( seconds: 1),
        (){
        Navigator.pushReplacement(
          context,
          PageTransition(child: LandingPage(), type: PageTransitionType.leftToRight),
        );
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0DFE1),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       RichText(
      //         text: TextSpan(
      //             text: 'jay',
      //             style: TextStyle(
      //               color: Colors.black87,
      //               fontFamily: 'Poppins',
      //               fontSize: 30.0,
      //             ),
      //             children: <TextSpan>[
      //               TextSpan(
      //                 text: 'Gram',
      //                 style: TextStyle(
      //                   fontSize: 34.0,
      //                   color: Colors.pink,
      //                 ),
      //               ),
      //             ]),
      //       ),
      //       Container(
      //         child: Column(
      //           children: [
      //             Text(
      //               'made by',
      //               style: TextStyle(
      //                 color: Colors.grey.shade600,
      //                 fontFamily: 'Poppins',
      //               ),
      //             ),
      //             SizedBox(
      //               height: 8.0,
      //             ),
      //             Text(
      //               'ANDERE',
      //               style: TextStyle(
      //                 color: Colors.pink,
      //                 fontSize: 20.0,
      //                 fontFamily: 'Poppins',
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Stack(
        children: [
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Align(
          //       alignment: Alignment.center,
          //       child: RichText(
          //                 text: TextSpan(
          //                     text: 'jay',
          //                     style: TextStyle(
          //                       color: Colors.black87,
          //                       fontFamily: 'Poppins',
          //                       fontSize: 30.0,
          //                     ),
          //                     children: <TextSpan>[
          //                       TextSpan(
          //                         text: 'Gram',
          //                         style: TextStyle(
          //                           fontSize: 34.0,
          //                           color: Colors.pink,
          //                         ),
          //                       ),
          //                     ]),
          //               ),
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 608.0),
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Column(
          //                 children: [
          //                   Text(
          //                     'made by',
          //                     style: TextStyle(
          //                       color: Colors.grey.shade600,
          //                       fontFamily: 'Poppins',
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 8.0,
          //                   ),
          //                   Text(
          //                     'ANDERE',
          //                     style: TextStyle(
          //                       color: Colors.pink,
          //                       fontSize: 20.0,
          //                       fontFamily: 'Poppins',
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          // ),
          Image.asset(
            'assets/images/social.jpg',
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black54,
            child: Center(
              child: Text(
                'Share Your',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
                  ],
                ),
          );

  }
}
