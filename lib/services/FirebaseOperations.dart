import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jamie/screens/landingpage/landing_utils.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:provider/provider.dart';

class FirebaseOperations with ChangeNotifier{

  UploadTask imageUploadTask;
  String initUserEmail;
  String initUserName;
  String initUserImage;
  String get getInitUserName => initUserName;
  String get getInitUserEmail => initUserEmail;
  String get getInitUserImage => initUserImage;


  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}'
    );
    imageUploadTask = imageReference.putFile(Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask.whenComplete(() {
      print('image uploaded');
    });
    imageReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl = url.toString();
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async{
    return FirebaseFirestore.instance.collection('users').doc(Provider.of<Authentication>(context, listen: false).getUserUid).set(data);
    
  }
  
  Future updateDocument(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance.collection('users').doc(
        Provider.of<Authentication>(context, listen: false).getUserUid
    ).update(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance.collection('users').doc(
        Provider.of<Authentication>(context, listen: false).getUserUid
    ).get().then((doc) {
      print('Fetching user data');
      initUserName = doc.data()['username'];
      initUserEmail = doc.data()['useremail'];
      initUserImage = doc.data()['userimage'];
      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(
      postId
    ).set(data);
  }

  Future deleteUserData(String userUid) async{
    return FirebaseFirestore.instance.collection('users').doc(userUid).delete();
  }
}