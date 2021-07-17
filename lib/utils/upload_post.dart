import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:jamie/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class UploadPost with ChangeNotifier{
  TextEditingController captionController = TextEditingController();

  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;

  final picker = ImagePicker();
  UploadTask imageUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async{
    final pickedUploadPostImage = await picker.getImage(source: source);
    pickedUploadPostImage == null ? print('select image')
        : uploadPostImage = File(pickedUploadPostImage.path);

    uploadPostImage != null ? showPostImage(context) : print('upload image error');
    notifyListeners();
  }

  Future uploadImageToFirebase() async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'posts/${uploadPostImage.path}/${TimeOfDay.now()}'
    );
    imageUploadTask = imageReference.putFile(uploadPostImage);
    await imageUploadTask.whenComplete(() {
      print('post image uploaded');
    });
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  selectPostImageType(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 3.0,
                  color: Colors.grey,
                ),
              ),
              MaterialButton(
                onPressed: (){
                  pickUploadPostImage(context, ImageSource.gallery);
                },
                child: Text(
                  'Gallery',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: (){
                  pickUploadPostImage(context, ImageSource.camera);
                },
                child: Text(
                  'Camera',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  showPostImage(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 3.0,
                    color: Colors.grey,
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                 child: Container(
                   height: 200.0,
                   width: 400.0,
                   child: Image.file(
                     uploadPostImage,
                     fit: BoxFit.contain,
                   ),
                 ),
               ),
                SizedBox(height: 12.0,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          selectPostImageType(context);
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
                          uploadImageToFirebase().whenComplete(() {
                            editPostSheet(context);
                            print('Image uploaded to firebase');
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
        }
    );
  }

  editPostSheet(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 3.0,
                  color: Colors.grey,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.image_aspect_ratio,
                              color: Colors.blue,
                            ),
                            onPressed: (){},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.fit_screen,
                              color: Colors.blue,
                            ),
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200.0,
                      width: 300.0,
                      child: Image.file(uploadPostImage, fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Icon(
                        Icons.edit_location_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    Container(
                      height: 110.0,
                      width: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 120.0,
                        width: 330.0,
                        child: TextField(
                          maxLines: 5,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          maxLength: 100,
                          controller: captionController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,

                          ),
                          decoration: InputDecoration(
                            hintText: 'Add a caption..',
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  Provider.of<FirebaseOperations>(context, listen: false).uploadPostData(
                    captionController.text, {
                      'caption' : captionController.text,
                    'postimage' : getUploadPostImageUrl,
                    'username' : Provider.of<FirebaseOperations>(context, listen: false).getInitUserName,
                    'userimage' : Provider.of<FirebaseOperations>(context, listen: false).getInitUserImage,
                    'useruid' : Provider.of<Authentication>(context, listen: false).getUserUid,
                    'time' : Timestamp.now(),
                    'useremail' : Provider.of<FirebaseOperations>(context, listen: false).getInitUserEmail,
                  }
                  ).whenComplete(() {
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.black,
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
        );
      }
    );
  }
}