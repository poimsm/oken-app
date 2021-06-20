import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(        
                children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.topRight,
                  child: IconButton(
                    color: Color(0xff333333),
                    icon: Icon(Icons.close, size: 32),
                    onPressed: () =>  Navigator.pop(context)),
                ),
                _logo(),
                _signUp(),
                SizedBox(height: 50)
                ],
              ),
            ),
          ),
         ) 
    );
  }

  Widget _logo() {
    return Image.asset('assets/logo.png');
  }

  Widget _signIn() {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),
        SizedBox(height: 15),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
        SizedBox(height: 15),
        Text('Forgot your password?', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
        SizedBox(height: 15),
        RaisedButton(
          padding: EdgeInsets.all(15),
          color: Colors.red,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.red)
          ),
          child: Text('Sign In', style: TextStyle(fontSize: 18),),
          onPressed: () {
          }
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text("Don't have an account?", style: TextStyle(color: Colors.grey),),
            SizedBox(width: 5),
            Text('Create', style: TextStyle(color: Colors.deepOrange),),
          ],
        )
      ],
    );
  }

  Widget _signUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),
        SizedBox(height: 15),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
          ),
        ),
        SizedBox(height: 15),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
        SizedBox(height: 15),
        RaisedButton(
          padding: EdgeInsets.all(15),
          color: Colors.red,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.red)
          ),
          child: Text('Sign Up', style: TextStyle(fontSize: 18),),
          onPressed: () {
          }
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text('Do you have an account?', style: TextStyle(color: Colors.grey),),
            SizedBox(width: 5),
            Text('Log in', style: TextStyle(color: Colors.deepOrange),),
          ],
        )
      ],
    );
  }
}