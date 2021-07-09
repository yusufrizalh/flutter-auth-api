import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pages/profile-page.dart';
import 'pages/student-page.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    routes: {
      '/profile': (context) => ProfilePage(),
      '/student': (context) => StudentData(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
      ),
      body: Center(
        child: LoginUser(),
      ),
    );
  }
}

class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  bool visible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    setState(() {
      visible = true;
    });

    // mengambil teks dari texteditingcontroller
    String email = emailController.text;
    String password = passwordController.text;

    // url lokasi api berada
    var url = 'http://192.168.10.82/myphp/flutter-api/login.php';
    var data = {'email': email, 'password': password};
    var response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    });
    var message = jsonDecode(response.body);

    // deteksi apakah login sesuai atau tidak
    if (message == 'Login matched!') {
      // jika matched
      setState(() {
        visible = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(email: emailController.text)));
    } else {
      // jika tidak matched
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok')),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Divider(),
              Container(
                width: 480,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Enter email here'),
                ),
              ),
              Container(
                width: 480,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: 'Enter your password'),
                ),
              ),
              RaisedButton(
                onPressed: userLogin,
                color: Colors.blueAccent,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text('Click to Login'),
              ),
              Visibility(
                visible: visible,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
