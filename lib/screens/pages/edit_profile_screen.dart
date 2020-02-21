import 'package:flutter/material.dart';
import 'package:instagrem/models/user.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _bio = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.white,
         title: Text(
           'Edit Profile',
           style: TextStyle(
             color: Colors.black,
           ),
           ),
       ),
       body: SingleChildScrollView(
         child: Container(
           height: MediaQuery.of(context).size.height,
           child: Form(
             key: _formKey,
             child: Column(
               children: <Widget>[
                 CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage('https://i.redd.it/dmdqlcdpjlwz.jpg'),
                  ),
                  FlatButton(
                    onPressed: () => print('Change profile img'),
                    child: Text('Change Profile Image',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ),
                TextFormField(
                  initialValue: _name,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      size: 30.0,
                    ),
                    labelText: 'Name',
                  ),
                  validator: (input) => input.trim().length < 1
                    ? 'Please enter valid name'
                    : null,
                  onSaved: (input) => _name = input,
                ),
                TextFormField(
                  initialValue: _bio,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.book,
                      size: 30.0,
                    ),
                    labelText: 'Bio',
                  ),
                  validator: (input) => input.trim().length > 150
                    ? 'Please enter a bio less than 150 characters'
                    : null,
                  onSaved: (input) => _bio = input,
                ),
                Container(
                  height: 40.0,
                  width: 250.0,
                  child: FlatButton(
                    onPressed: () => print('save'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      'Save Profile',
                      style: TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                  ),
                )
               ],
             ),
           ),
         ),
       ),
    );
  }
}