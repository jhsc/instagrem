import 'package:flutter/material.dart';
import 'package:instagrem/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = "register_screen";

  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Register user w/ firebase
      AuthService.signUpUser(context, _name, _email, _password);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Instagrem",
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize:  50.0),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Name"),
                        validator: (input) => input.trim().isEmpty
                        ? "Please enter valid name"
                        : null,
                        onSaved: (input) => _name = input,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Email"),
                        validator: (input) => !input.contains('@') ? "Please enter valid email" : null,
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Password"),
                        validator: (input) => input.length < 6 ? "Must be at least 6 characters" : null,
                        onSaved: (input) => _password = input.trim(),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        onPressed: _submit,
                        color: Colors.blue,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        color: Colors.blue,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}