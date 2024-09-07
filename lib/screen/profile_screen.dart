import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:isntragram_clone/data/model/usermodel.dart';
import 'package:isntragram_clone/screen/post_screen.dart';
import '../data/firebase_services/firestore.dart';
import '../util/image_cached.dart';

class ProfileScreen extends StatefulWidget {
  final String Uid;
  ProfileScreen({super.key, required this.Uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isCurrentUser = false;
  List following = [];
  bool follow = false;
  late List<String> PostedVideoUrls = [];
  late VlcPlayerController _controller;
  @override
  void initState() {
    super.initState();
    getData();
    if (widget.Uid == _auth.currentUser!.uid) {
      setState(() {
        isCurrentUser = true;
      });
    }
    fetchVideoUrls(widget.Uid);
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<void> getData() async {
    try {
      DocumentSnapshot snap = await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      following = (snap.data()! as dynamic)['following'] ?? [];
      if (following.contains(widget.Uid)) {
        setState(() {
          follow = true;
        });
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> fetchVideoUrls(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('reels')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No videos found for user $uid.');
        return;
      }

      setState(() {
        PostedVideoUrls = querySnapshot.docs.map((doc) {
          // Fetch the 'reelsvideo' field which contains the video URL
          return doc.get('reelsvideo') as String;
        }).toList();
      });

      print("Fetched video URLs: $PostedVideoUrls"); // Debug print
    } catch (e) {
      print('Error fetching video URLs: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: FutureBuilder<Usermodel>(
                  future: Firebase_Firestor().getUser(uidd: widget.Uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text('User not found.'));
                    }
                    return Head(snapshot.data!);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 30.h,
                child: const TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on)),
                    Tab(icon: Icon(Icons.video_collection)),
                    Tab(icon: Icon(Icons.person)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Posts(),
                    Reels(),
                    Center(child: Text('About content here')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Head(Usermodel user) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                child: ClipOval(
                  child: SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: CachedImage(user.profile),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      Column(
                        children: [
                          Text(
                            '0', // Update with actual post count if needed
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            'Posts',
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 25.w),
                      Column(
                        children: [
                          Text(
                            user.followers.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 25.w),
                      Column(
                        children: [
                          Text(
                            user.following.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  user.bio,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Visibility(
            visible: !follow,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: GestureDetector(
                onTap: () {
                  if (!isCurrentUser) {
                    Firebase_Firestor().flollow(uid: widget.Uid);
                    setState(() {
                      follow = true;
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isCurrentUser ? Colors.white : Colors.blue,
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(
                        color: isCurrentUser ? Colors.grey.shade400 : Colors.blue),
                  ),
                  child: isCurrentUser
                      ? Text('Edit Your Profile')
                      : Text(
                    'Follow',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: follow,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Firebase_Firestor().flollow(uid: widget.Uid);
                        setState(() {
                          follow = false;
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 30.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Text('Unfollow')),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        'Message',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  Widget Posts() {
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
        if (snapshot.data!.docs.isEmpty) {
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
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PostScreen(snap.data())));
                },
                child: CachedImage(snap['postImage']));
          },
        );
      },
    );
  }

  Widget Reels() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: PostedVideoUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 250,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 5.h,
      ),
      itemBuilder: (BuildContext context, int index) {
        final videoUrl = PostedVideoUrls[index];
        final VlcPlayerController controller = VlcPlayerController.network(
          videoUrl,
          autoPlay: true,
          options: VlcPlayerOptions(),
        );

        // Set the volume to 0


        return GestureDetector(
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => ReelsEditeScreen(videoUrl),
          //     ),
          //   );
          // },
          child: Container(
            margin: EdgeInsets.all(4.0),
            child: VlcPlayer(
              controller: controller,

              aspectRatio: 16 / 9,
              placeholder: Center(child: CircularProgressIndicator()),
              // Add more customization here if needed
            ),
          ),
        );
      },
    );
  }

}
