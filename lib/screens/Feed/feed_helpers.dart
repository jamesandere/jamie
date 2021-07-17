import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jamie/services/Authentication.dart';
import 'package:jamie/utils/PostOptions.dart';
import 'package:jamie/utils/upload_post.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FeedHelpers with ChangeNotifier{

  Widget appBar(BuildContext context){
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.grey.shade200,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          icon: Icon(
            Icons.camera_enhance_rounded,
            color: Colors.black,
          ),
          onPressed: (){
            Provider.of<UploadPost>(context, listen: false).selectPostImageType(context);
          },
        ),
      ],
      title: RichText(
        text: TextSpan(
          text: 'Jay ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Gram',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget feedBody(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: SizedBox(
                    height: 500.0,
                    width: 400.0,
                    child: Lottie.asset('assets/animations.loading.json'),
                  ),
                );
              }
              else{
                return loadPosts(context, snapshot);
              }
            },
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget loadPosts(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.62,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20.0,
                        backgroundImage: documentSnapshot.data()['userimage'] != null ? NetworkImage(
                          documentSnapshot.data()['userimage'],
                        ) : AssetImage('assets/images/empty.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                documentSnapshot.data()['caption'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  text: documentSnapshot.data()['username'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' , 12 hours ago',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.46,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    child: documentSnapshot.data()['postimage'] != null ? Image.network(
                      documentSnapshot.data()['postimage'],
                      scale: 2,
                    ) : Image.asset('assets/images/social.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onLongPress: (){
                                Provider.of<PostFunctions>(context, listen: false).showLikes(context, documentSnapshot.data()['caption']);
                              },
                              onTap: (){
                                Provider.of<PostFunctions>(context, listen: false).addLike(context, documentSnapshot.data()['caption'],
                                    Provider.of<Authentication>(context, listen: false).getUserUid);
                              },
                              child: Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.black26,
                                size: 22.0,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('posts').doc(
                                documentSnapshot.data()['caption']
                              ).collection('likes').snapshots(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                else{
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Provider.of<PostFunctions>(context, listen: false).showCommentSheet(context,
                                    documentSnapshot, documentSnapshot.data()['caption']);
                              },
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: Colors.black26,
                                size: 22.0,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('posts').doc(
                                  documentSnapshot.data()['caption']
                              ).collection('comments').snapshots(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                else{
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Provider.of<PostFunctions>(context, listen: false).showRewards(context);
                              },
                              child: Icon(
                                FontAwesomeIcons.award,
                                color: Colors.black26,
                                size: 22.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Provider.of<Authentication>(context, listen: false).getUserUid == documentSnapshot.data()['useruid'] ?
                      IconButton(
                        icon: Icon(
                          EvaIcons.moreVertical,
                          color: Colors.black,
                        ),
                        onPressed: (){},
                      ) : Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      }).toList(),
    );
  }
}