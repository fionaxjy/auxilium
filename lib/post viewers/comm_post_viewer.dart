import 'package:auxilium/post%20viewers/post_format.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../post_cache.dart';

Widget commPostViewer(GoogleSignInAccount user, GoogleSignIn googleSignIn,
    String dp, String username) {
  RetrievePost retrievePost = RetrievePost(user, googleSignIn, dp, username);
  List<Post> posts = retrievePost.loadCommunityPostCache();
  return Container(
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
  );
}
