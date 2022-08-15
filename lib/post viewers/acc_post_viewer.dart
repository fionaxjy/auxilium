import 'package:auxilium/post%20viewers/post_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../post_cache.dart';

CollectionReference postsRef = FirebaseFirestore.instance.collection('Posts');

Widget accDonatingPostViewer(GoogleSignInAccount user,
    GoogleSignIn googleSignIn, String dp, String username) {
  List<Post> postsDon = [
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '0000',
      dp: dp,
      username: username,
      timeAgo: '5m',
      content:
          'Free Past Year Assessment Papers, O-Level Math and Science (2018-2021)',
      title: 'O-Level Past Year Papers',
      comments: '0',
      reqOrDonTag: 'don',
      causeTag: 'Education',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '0008',
      dp: dp,
      username: username,
      timeAgo: '2d',
      content:
          'Used for about 3 years. Good working condition and battery life, very few scratches. Got a new phone and can pass this one down!',
      title: 'Used iPhone 5S',
      comments: '0',
      reqOrDonTag: 'don',
      causeTag: 'Utilities',
    ),
  ];
  /*Future<List<Post>> loadCommunityPostCache() async {
    QuerySnapshot snapshot = await postsRef
        .doc(user.id)
        .collection('Posts')
        .orderBy('dateAndTime', descending: true)
        .limit(50)
        .get();
    List<Post> postItems = [];
    for (var doc in snapshot.docs) {
      postItems.add(Post.fromDoc(user, googleSignIn, doc));
    }
    print(postItems.length);
    return postItems;*/
  return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 24, 0),
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return postsDon[index];
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
          ),
          itemCount: postsDon.length,
        ),
      ));
}

/*return FutureBuilder(
    future: loadCommunityPostCache(), //loadDonatingAccPostCache
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
            child: Text(
          'no posts at the moment.\n start donating!',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Color.fromARGB(255, 65, 82, 31), fontSize: 18),
        ));
      }
      return ListView(
        children: snapshot.data,
      );
    },
  );
}*/

Widget accRequestingPostViewer(GoogleSignInAccount user,
    GoogleSignIn googleSignIn, String dp, String username) {
  /*Future<List<Post>> loadCommunityPostCache() async {
    QuerySnapshot snapshot = await postsRef
        .doc(user.id)
        .collection('Posts')
        .orderBy('dateAndTime', descending: true)
        .limit(50)
        .get();
    List<Post> postItems = [];
    snapshot.docs.forEach((doc) {
      postItems.add(Post.fromDoc(user, googleSignIn, doc));
    });
    print(postItems.length);
    return postItems;
  }

  return FutureBuilder(
    future: loadCommunityPostCache(), //loadRequestingAccPostCache
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
            child: Text(
          'no posts at the moment.\n start requesting!',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Color.fromARGB(255, 65, 82, 31), fontSize: 18),
        ));
      }
      return ListView(
        children: snapshot.data,
      );
    },
  );*/
  List<Post> postsReq = [
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '0011',
      dp: dp,
      username: username,
      timeAgo: 'Now',
      content:
          'Anyone have a spare charging cable I can borrow for about a week?',
      title: 'Need iPhone Lightning USB Cable',
      comments: '0',
      reqOrDonTag: 'req',
      causeTag: 'Utilities',
    )
  ];
  return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 24, 0),
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return postsReq[index];
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
          ),
          itemCount: postsReq.length,
        ),
      ));
}
