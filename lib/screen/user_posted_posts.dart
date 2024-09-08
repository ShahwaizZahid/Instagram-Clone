import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:isntragram_clone/screen/post_screen.dart';
import '../util/image_cached.dart';

class UserPostedPosts extends StatefulWidget {
  final String Uid;

  UserPostedPosts({super.key, required this.Uid});

  @override
  State<UserPostedPosts> createState() => _UserPostedPostsState();
}

class _UserPostedPostsState extends State<UserPostedPosts> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('posts')
          .where('uid', isEqualTo: widget.Uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No posts available.'));
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var snap = snapshot.data!.docs[index];
            // Cast to Map<String, dynamic> if necessary
            var postData = snap.data() as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PostScreen(postData),
                  ),
                );
              },
              child: CachedImage(postData['postImage']),
            );
          },
        );
      },
    );
  }
}
