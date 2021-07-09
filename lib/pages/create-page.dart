import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../environment.dart';
import '../widget/form.dart';

class CreateData extends StatefulWidget {
  final Function refreshStudentList;
  CreateData({this.refreshStudentList});

  @override
  CreateDataState createState() => CreateDataState();
}

class CreateDataState extends State<CreateData> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  Future createStudent() async {
    final url = '${Environment.URL_PREFIX}/create.php';
    return await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: {
        "name": nameController.text,
        "age": ageController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Data'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text('CREATE'),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: () {
            if (formKey.currentState.validate()) {
              confirmSave(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: AppForm(
          formKey: formKey,
          nameController: nameController,
          ageController: ageController,
        ),
      ),
    );
  }

  void confirmSave(BuildContext context) async {
    await createStudent();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/student', (Route<dynamic> route) => false);
  }
}
