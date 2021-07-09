import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController;
  TextEditingController ageController;

  AppForm({this.formKey, this.nameController, this.ageController});

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  String validateName(String value) {
    if (value.length < 9) return 'Nama minimal 8 karakter';
    return null;
  }

  String validateAge(String value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Usia hanya bisa angka';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: widget.nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Name'),
            validator: validateName,
          ),
          TextFormField(
            controller: widget.ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Age'),
            validator: validateAge,
          ),
        ],
      ),
    );
  }
}
