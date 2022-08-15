import 'package:auxilium/post%20viewers/post_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../post_cache.dart';

CollectionReference postsRef = FirebaseFirestore.instance.collection('Posts');

Widget commPostViewer(GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  List<Post> posts = [
    /*Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '0001',
      dp: dp,
      username: username,
      timeAgo: 'Now',
      content:
          'Anyone have a spare charging cable I can borrow for about a week?',
      title: 'Need iPhone Lightning USB Cable',
      comments: '0',
      reqOrDonTag: 'req',
      causeTag: 'Utilities',
    ),*/
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '0',
      dp: user.photoUrl,
      username: user.displayName,
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
      postId: '1',
      dp: 'https://qph.cf2.quoracdn.net/main-qimg-3d526e5a6d0c2ec3ba9749ff68fef27b-lq',
      username: 'Maria',
      timeAgo: '5m',
      content: 'Free English tuition! Teaching P3-P6.',
      title: 'Primary School Tuition',
      comments: '3',
      reqOrDonTag: 'don',
      causeTag: 'Education',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '2',
      dp: 'https://bestprofilepictures.com/wp-content/uploads/2020/07/Cool-Profile-Picture-For-Instagram-1003x1024.jpg',
      username: 'Jameson',
      timeAgo: '12m',
      content: 'Expiring soon and just want to clear!',
      title: '5 packs of Indomee',
      comments: '3',
      reqOrDonTag: 'don',
      causeTag: 'Food',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '3',
      dp: 'https://i.pinimg.com/originals/1f/50/a0/1f50a07ce3abdeb3c1f507b418f9a9ab.jpg',
      username: 'Linda',
      timeAgo: '18m',
      content:
          'Need babysitter to help with taking care of 5 y.o. as I go to work tomorrow',
      title: 'Babysitter',
      comments: '1',
      reqOrDonTag: 'req',
      causeTag: 'Others',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '4',
      dp: 'https://qph.cf2.quoracdn.net/main-qimg-a5b043b339378653070af9d475827ad1-lq',
      username: 'Andrea',
      timeAgo: '20m',
      content:
          'Leftover chicken pie from yesterday\'s dinner, fully untouched and really good! Come by, all invited.',
      title: 'Chicken Pie',
      comments: '5',
      reqOrDonTag: 'don',
      causeTag: 'Food',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '5',
      dp: 'https://media.istockphoto.com/photos/lion-in-portrait-with-isolated-black-background-picture-id635973758?k=20&m=635973758&s=612x612&w=0&h=RulShq1W-tquDFO_7FM05eRJbwGzrajWcvV6xRlIUlI=',
      username: 'Marcus',
      timeAgo: '26m',
      content: 'Looking for workspace to study for my PSLE',
      title: 'Study Space',
      comments: '2',
      reqOrDonTag: 'req',
      causeTag: 'Space',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '6',
      dp: 'https://i.pinimg.com/736x/d4/b6/50/d4b65035e22d84f7b95f98fe715f8480.jpg',
      username: 'Yolanda',
      timeAgo: '40m',
      content: 'Need a new washing machine! Anyone have contacts?',
      title: 'Washing Machine',
      comments: '10',
      reqOrDonTag: 'req',
      causeTag: 'Utilities',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '7',
      dp: 'https://us.123rf.com/450wm/fizkes/fizkes2007/fizkes200701872/152319944-close-up-headshot-portrait-of-smiling-vietnamese-young-woman-look-at-camera-talk-on-video-call-profi.jpg?ver=6',
      username: 'Trisha',
      timeAgo: '1h',
      content: 'donating out a free airfryer',
      title: 'Airfryer',
      comments: '7',
      reqOrDonTag: 'don',
      causeTag: 'Utilities',
    ),
    Post(
      user: user,
      googleSignIn: googleSignIn,
      userId: user.id,
      postId: '8',
      dp: user.photoUrl,
      username: user.displayName,
      timeAgo: '2d',
      content:
          'Used for about 3 years. Good working condition and battery life, very few scratches. Got a new phone and can pass this one down!',
      title: 'Used iPhone 5S',
      comments: '0',
      reqOrDonTag: 'don',
      causeTag: 'Utilities',
    ),
  ];
  return Padding(
      padding: EdgeInsets.fromLTRB(14, 0, 24, 0),
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return posts[index];
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
          ),
          itemCount: posts.length,
        ),
      ));
}

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
      print('one');
    }
    print(postItems.length);
    return postItems;
  }

  return FutureBuilder(
    future: loadCommunityPostCache(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return  Center(
            child: Text(
          'no posts at the moment.\n be the first to start!',
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

