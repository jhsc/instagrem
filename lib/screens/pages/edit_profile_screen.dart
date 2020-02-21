import 'package:flutter/material.dart';
import 'package:instagrem/models/user.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.white,
         title: Text('Edit Profile'),
       ),
    );
  }
}