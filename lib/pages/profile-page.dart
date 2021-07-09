import 'package:flutter/material.dart';
import 'student-page.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  ProfilePage({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Page'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  // buat fungsi logout
                  logout(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Welcome, ' + email,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  navigateToStudentData(context);
                },
                color: Colors.blueAccent,
                child: Text(
                  'Open Students Data',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logout(BuildContext context) {
    Navigator.pop(context);
    // ada kill session
  }

  navigateToStudentData(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => StudentData()));
  }
}
