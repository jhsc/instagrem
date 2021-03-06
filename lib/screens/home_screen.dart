import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagrem/models/user_data.dart';
import 'package:instagrem/screens/pages/activity_screen.dart';
import 'package:instagrem/screens/pages/create_post_screen.dart';
import 'package:instagrem/screens/pages/feed_screen.dart';
import 'package:instagrem/screens/pages/profile_screen.dart';
import 'package:instagrem/screens/pages/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  // final String userId;
  HomeScreen({Key key,}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreatePostScreen(),
          ActivityScreen(),
          ProfileScreen(
            userId: currentUserId,
            currentUserId: currentUserId,
          ),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
            index, duration: Duration(milliseconds: 200),
            curve: Curves.easeIn
          );
        },
        activeColor: Colors.black,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32.0,
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 32.0,
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 32.0,
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 32.0,
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle ,
              size: 32.0,
            )
          ),
        ],
      ),
    );
  }
}