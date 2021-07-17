import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jamie/screens/Chatroom/chatroom.dart';
import 'package:jamie/screens/Feed/feed.dart';
import 'package:jamie/screens/Profile/profile.dart';
import 'package:jamie/screens/homepage/homepage_helpers.dart';
import 'package:jamie/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController homePageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false).initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: homePageController,
        children: [
          Feed(),
          Chatroom(),
          Profile(),
        ],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page){
          setState(() {
            pageIndex = page;
          });
        },
      ),
      bottomNavigationBar: Provider.of<HomePageHelpers>(context, listen: false).bottomNavBar(context, pageIndex, homePageController),
    );
  }
}
