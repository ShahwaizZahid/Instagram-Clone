import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isntragram_clone/data/model/usermodel.dart';
import 'package:isntragram_clone/screen/post_screen.dart';
import '../data/firebase_services/firestore.dart';
import '../util/image_cached.dart';

class ProfileScreen extends StatefulWidget {
  String Uid;
  ProfileScreen({super.key, required this.Uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int post_lenght = 0;
  bool yourse = false;
  List following = [];
  bool follow = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    if (widget.Uid == _auth.currentUser!.uid) {
      setState(() {
        yourse = true;
      });
    }
  }
  getdata() async {
    DocumentSnapshot snap = await _firebaseFirestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    following = (snap.data()! as dynamic)['following'];
    if (following.contains(widget.Uid)) {
      setState(() {
        follow = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: Firebase_Firestor().getUser(uidd: widget.Uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Head(snapshot.data!);
                  },
                ),
              ),
              StreamBuilder(
                stream: _firebaseFirestore
                    .collection('posts')
                    .where('uid', isEqualTo: widget.Uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No posts available.'));
                  }
                  var snaplength = snapshot.data!.docs.length;
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      var snap = snapshot.data!.docs[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PostScreen(snap.data())));
                          },
                          child: CachedImage(snap['postImage']));
                    }, childCount: snaplength),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Head(Usermodel user) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.h),
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
                    height: 80.h,
                    width: 80.w,
                    child: Container(child: CachedImage(user.profile)),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 17.w,
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 53.w,
                      ),
                      Text(
                        user.followers.length.toString(),
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 53.w,
                      ),
                      Text(
                        user.following.length.toString(),
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        'Follower',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  user.bio,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Container(
              alignment: Alignment.center,
              height: 20.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color:yourse ? Colors.grey.shade400: Colors.blue,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: Colors.grey.shade400)),
              child:yourse
                  ? const Text('Edit Your Profile')
                  : const Text(
                'Follow',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 35.h,
            child: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor:
                  Colors.black, // Color of the underline for the selected tab
              indicatorWeight: 2.5, // Thickness of the underline
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.symmetric(vertical: 8.0),
              tabs: [
                Icon(Icons.grid_on),
                Icon(Icons.video_collection),
                Icon(Icons.person)
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
