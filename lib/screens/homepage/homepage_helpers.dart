import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jamie/screens/Profile/profile.dart';
import 'package:jamie/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class HomePageHelpers with ChangeNotifier{

  Widget bottomNavBar(BuildContext context, int index, PageController pageController){
    return CustomNavigationBar(
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      selectedColor: Colors.pinkAccent,
      unSelectedColor: Colors.black,
      strokeColor: Colors.pink,
      scaleFactor: 0.5,
      iconSize: 30.0,
      onTap: (val){
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      backgroundColor: Colors.grey.shade200,
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            Icons.home,
          )
        ),
        CustomNavigationBarItem(
            icon: Icon(
              Icons.message_rounded,
            )
        ),
        CustomNavigationBarItem(
            icon: CircleAvatar(
              radius: 35.0,
              backgroundColor: Colors.black,
              backgroundImage: Provider.of<FirebaseOperations>(context, listen: false).initUserImage !=null ? NetworkImage(Provider.of<FirebaseOperations>(context, listen: false).getInitUserImage)
              : AssetImage('assets/images/emptyperson.png'),
            ),
        ),
      ],
    );
  }
}