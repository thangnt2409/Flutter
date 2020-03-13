import 'package:crudemployeeapp/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  Widget title;
  DialogPage({this.title});

  @override
  DialogPageState createState() {
    return DialogPageState();
  }
}

class DialogPageState extends State<DialogPage> {
  final formKey = new GlobalKey<FormState>();

  void _submit(BuildContext context, Employee employee) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.pop(context, Employee.fromObject(employee));
    }
  }

  @override
  Widget build(context) {
    Employee employee = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
          key: formKey,
          child: Dialog(
            child: Container(
              height: 310,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  widget.title,
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: TextEditingController()..text = employee != null ? employee.name: null,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          onSaved: (value) => employee.name = value,
                          decoration: InputDecoration(
                              hintText: "Enter your name",
                              icon: Icon(Icons.person)),
                          autofocus: true),
                      TextFormField(
                          controller: TextEditingController()..text = (employee != null ? employee.age.toString(): null),
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          validator: (value) {
                            RegExp regExp = new RegExp(r'(^[0-9]+$)');
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter valid age';
                            }
                            return null;
                          },
                          onSaved: (newValue) => employee.age = int.parse(newValue.toString()),
                          decoration: InputDecoration(
                              hintText: "Enter your age",
                              icon: Icon(Icons.confirmation_number))),
                      TextFormField(
                          controller: TextEditingController()..text = employee != null ? employee.address: null,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (newValue) => employee.address = newValue,
                          decoration: InputDecoration(
                              hintText: "Enter your address",
                              icon: Icon(Icons.home)))
                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel")),
                      FlatButton(
                          onPressed: () => _submit(context, employee),
                          child: Text("Save"))
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
