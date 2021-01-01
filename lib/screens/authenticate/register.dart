import 'package:brew_crew/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  // named parameter constructor: when calling constructor, have to use named param
  // i.e Register(toggleView: toggleView)
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}
        
class _RegisterState extends State<Register> {
  // auth in order to access auth service
  // formKey in order to enable validation for register form
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Sign Up for Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In"))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                // Email Form Field
                TextFormField(
                  validator: (value){
                    return value.isEmpty ? "Enter an email" : null;
                  },
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),

                SizedBox(height: 20.0),
                // Password Form Field
                TextFormField(
                  validator: (value){
                    return value.length < 6 ? "Please enter a password 6+ characters long" : null;
                  },
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),

                SizedBox(height: 20.0),
                RaisedButton(
                  color:Colors.pink[400],
                  child: Text("Sign up", style: TextStyle(color: Colors.white)),
                  // Sign up button
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      // if form fields are valid proceed with register
                      // result is dynamic because it could be null
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                      if(result == null){
                        setState(() {
                          error = "Please use a valid e-mail and password";
                        });
                      }
                    }
                  },
                ),
                SizedBox(height:12.0),
                // Error message
                Text(error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)
                )
              ],
            ),
          )
      ),
    );
  }
}
