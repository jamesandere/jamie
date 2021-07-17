import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jamie/screens/landingpage/landing_helpers.dart';
import 'package:provider/provider.dart';

class LandingUtils with ChangeNotifier{
  final picker = ImagePicker();
  File userAvatar;
  File get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null ? print('Select Image') : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null ? Provider.of<LandingHelpers>(context, listen: false).showUserAvatar(context) : print('image upload error');
    notifyListeners();
  }

  Future selectAvatarSheet(BuildContext context) async{
    return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: (){
                  pickUserAvatar(context, ImageSource.gallery).whenComplete(() {
                    Navigator.pop(context);
                    Provider.of<LandingHelpers>(context, listen: false).showUserAvatar(context);
                  });
                },
                child: Text(
                  'Gallery',
                ),
              ),
              MaterialButton(
                onPressed: (){
                  pickUserAvatar(context, ImageSource.camera).whenComplete(() {
                    Navigator.pop(context);
                    Provider.of<LandingHelpers>(context, listen: false).showUserAvatar(context);
                  });
                },
                child: Text(
                  'Camera',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}