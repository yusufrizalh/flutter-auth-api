import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'create-page.dart';
import 'detail-page.dart';
import 'profile-page.dart';
import '../models/student.dart';
import '../environment.dart';

class StudentData extends StatefulWidget {
  StudentData({Key key}) : super(key: key);
  @override
  StudentDataState createState() => StudentDataState();
}

class StudentDataState extends State<StudentData> {
  Future<List<Student>> students;
  final studentListKey = GlobalKey<StudentDataState>();

  @override
  void initState() {
    super.initState();
    students = getStudentList();
  }

  Future<List<Student>> getStudentList() async {
    final url = '${Environment.URL_PREFIX}/list.php';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Student> students = items.map<Student>((json) {
      return Student.fromJson(json);
    }).toList();
    return students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Center(
        child: FutureBuilder(
            future: students,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // deteksi ada data atau tidak
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        trailing: Icon(Icons.view_list),
                        title: Text(
                          data.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          // diarahkan ke detail student
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailStudent(student: data)),
                          );
                        },
                      ),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // diarahkan ke form tambah data student
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CreateData();
          }));
        },
      ),
    );
  }
}
