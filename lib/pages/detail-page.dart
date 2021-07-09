import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student.dart';
import '../environment.dart';
import 'edit-page.dart';

class DetailStudent extends StatefulWidget {
  final Student student;
  DetailStudent({this.student});

  @override
  DetailStudentState createState() => DetailStudentState();
}

class DetailStudentState extends State<DetailStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Student'),
        actions: <Widget>[
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        height: 300.0,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ${widget.student.name}',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Text(
              'Age: ${widget.student.age}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      EditData(student: widget.student),
                ),
              )),
    );
  }

  void confirmDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Are you sure want to delete?'),
            actions: <Widget>[
              RaisedButton(
                child: Icon(Icons.cancel),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
              RaisedButton(
                child: Icon(Icons.check_circle),
                color: Colors.redAccent,
                textColor: Colors.white,
                onPressed: () => deleteStudent(context),
              ),
            ],
          );
        });
  }

  void deleteStudent(BuildContext context) async {
    final url = '${Environment.URL_PREFIX}/delete.php';
    await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: {
        'id': widget.student.id.toString(),
      },
    );
    Navigator.of(context).pushReplacementNamed('/student');
  }
}
