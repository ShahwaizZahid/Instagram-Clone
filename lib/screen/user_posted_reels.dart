import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class UserPostedReels extends StatefulWidget {
  final String Uid;

  UserPostedReels({super.key, required this.Uid});

  @override
  State<UserPostedReels> createState() => _UserPostedReelsState();
}

class _UserPostedReelsState extends State<UserPostedReels> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late List<String> PostedVideoUrls = [];

  @override
  void initState() {
    super.initState();
    fetchVideoUrls(widget.Uid);
  }

  Future<void> fetchVideoUrls(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('reels')
          .where('uid', isEqualTo: widget.Uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No videos found for user $uid.');
        return;
      }

      setState(() {
        PostedVideoUrls = querySnapshot.docs.map((doc) {
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
        controller.setVolume(0);

        return GestureDetector(
          onTap: () {
            // Add functionality for tapping if needed
          },
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

  @override
  void dispose() {
    // Ensure to dispose controllers properly to avoid memory leaks
    super.dispose();
  }
}
