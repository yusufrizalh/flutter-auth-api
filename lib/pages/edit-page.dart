import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student.dart';
import '../environment.dart';
import '../widget/form.dart';

class EditData extends StatefulWidget {
  final Student student;
  EditData({this.student});

  @override
  EditDataState createState() => EditDataState();
}

class EditDataState extends State<EditData> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController ageController;

  Future editStudent() async {
    final url = '${Environment.URL_PREFIX}/update.php';
    return await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: {
        "id": widget.student.id.toString(),
        "name": nameController.text,
        "age": ageController.text,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text('Update'),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: () {
            confirmUpdate(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: AppForm(
              formKey: formKey,
              nameController: nameController,
              ageController: ageController,
            ),
          ),
        ),
      ),
    );
  }

  void confirmUpdate(BuildContext context) async {
    await editStudent();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/student', (Route<dynamic> route) => false);
  }
}
