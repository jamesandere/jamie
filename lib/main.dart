import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jamie/screens/Feed/feed_helpers.dart';
import 'package:jamie/screens/Profile/profile_helpers.dart';
import 'package:jamie/screens/homepage/homepage_helpers.dart';
import 'package:jamie/screens/landingpage/landing_helpers.dart';
import 'package:jamie/screens/landingpage/landing_utils.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:jamie/services/FirebaseOperations.dart';
import 'package:jamie/utils/PostOptions.dart';
import 'package:jamie/utils/upload_post.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/jamie/lib/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LandingHelpers()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => LandingUtils()),
        ChangeNotifierProvider(create: (_) => HomePageHelpers()),
        ChangeNotifierProvider(create: (_) => ProfileHelpers()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
        ChangeNotifierProvider(create: (_) => FeedHelpers()),
        ChangeNotifierProvider(create: (_) => PostFunctions()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.white,
        // ),
        home: SplashScreen(),
      ),
    );
  }
}
