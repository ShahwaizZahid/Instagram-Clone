import 'package:flutter/material.dart';

import 'add_post_screen.dart';
import 'add_reel_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}
int _currentIndex = 0;
class _AddScreenState extends State<AddScreen> {
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  navigationTapped(int page) {
    pageController.jumpToPage(page);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [

            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [
                AddPostScreen(),
                AddReelsScreen(),
              ],
            ),
            ]
      )),
    );
  }
}
