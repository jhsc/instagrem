import 'package:flutter/material.dart';
import 'package:instagrem/services/auth_service.dart';

class FeedScreen extends StatefulWidget {
  static final String id = "feed_screen";

  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: FlatButton(
          onPressed: () => AuthService.logout(context),
          child: Text('LOGOUT')
        ),
      ),
    );
  }
}