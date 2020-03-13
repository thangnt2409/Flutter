import 'package:crudemployeeapp/models/employee.dart';
import 'package:crudemployeeapp/services/response/employee_response.dart';
import 'package:crudemployeeapp/utils/dialog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  EmployeeState createState() {
    // TODO: implement createState
    return EmployeeState();
  }
}

class EmployeeState extends State<Home>
    implements
        CreateEmployeeCallBack,
        UpdateEmployeeCallBack,
        DeleteEmployeeCallBack,
        GetEmployeeCallBack {
  List<Employee> listEmployee;
  CreateEmployeeResponse _createEmployeeResponse;
  UpdateEmployeeResponse _updateEmployeeResponse;
  GetEmployeeResponse _getEmployeeResponse;
  DeleteEmployeeResponse _deleteEmployeeResponse;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  EmployeeState() {
    listEmployee = new List<Employee>();
    _createEmployeeResponse = new CreateEmployeeResponse(this);
    _deleteEmployeeResponse = new DeleteEmployeeResponse(this);
    _updateEmployeeResponse = new UpdateEmployeeResponse(this);
    _getEmployeeResponse = new GetEmployeeResponse(this);
    _getEmployeeResponse.doGet();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("EMPLOYEE"),
      ),
      body: buildListView(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showCustomDialog(context,"CREATE EMPLOYEE", null),
          child: Icon(Icons.library_add)),
    );
  }

  _showCustomDialog(BuildContext context, String title, Employee employee) async {
    Employee result = await Navigator. push(
      context,
      MaterialPageRoute(
          builder: (context) => DialogPage(
              title: Text(title, style: TextStyle(fontSize: 20))),
          settings: RouteSettings(arguments: employee)),
    );

    if (result != null) {
      if (result.id != null) {
        _updateEmployeeResponse.doUpdate(result);
      } else {
        _createEmployeeResponse.doCreate(result);
      }
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: Text(text)));
  }

  Widget buildListView() {
    return ListView(
      children: _buildListItem(),
    );
  }

  List<GestureDetector> _buildListItem() {
    return listEmployee.map((employee) {
      var container = Container(
        margin: const EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            SizedBox.fromSize(
              size: Size(50, 50), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.green, // button color
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(employee.name[0]), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      employee.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    employee.address,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Text("Age: " +
                (employee.age < 10
                    ? "0" + employee.age.toString()
                    : employee.age.toString())),
            IconButton(icon: Icon(Icons.delete_forever), onPressed: () => _deleteEmployeeResponse.doDelete(employee.id),)
          ],
        ),
      );
      return GestureDetector(
        child: Card(
          child: container,
        ),
        onTap: () => _showCustomDialog(context,"UPDATE EMPLOYEE", employee),
      );
    }).toList();
  }

  @override
  void onCreateEmployeeError(String error) {
    // TODO: implement onCreateEmployeeError
    print(error);
    _showSnackBar(error);
  }

  @override
  void onCreateEmployeeSuccess(int value) {
    // TODO: implement onCreateEmployeeSuccess
    if (value > 0) {
      _getEmployeeResponse.doGet();
      _showSnackBar("data has been saved successfully");
    } else {
      _showSnackBar("Failed, please check dara");
    }
  }

  @override
  void onDeleteEmployeeError(String error) {
    // TODO: implement onDeleteEmployeeError
    print(error);
    _showSnackBar(error);
  }

  @override
  void onDeleteEmployeeSuccess(int value) {
    // TODO: implement onDeleteEmployeeSuccess
    if (value > 0) {
      _getEmployeeResponse.doGet();
      _showSnackBar("data has been saved successfully");
    } else {
      _showSnackBar("Failed, please check dara");
    }
  }

  @override
  void onGetEmployeeError(String error) {
    // TODO: implement onGetEmployeeError
    print(error);
    _showSnackBar(error);
  }

  @override
  void onGetEmployeeSuccess(List<Employee> employees) {
    // TODO: implement onGetEmployeeSuccess
    if (employees != null) {
      setState(() {
        listEmployee = employees;
      });
    }
  }

  @override
  void onUpdateEmployeeError(String error) {
    // TODO: implement onUpdateEmployeeError
    print(error);
    _showSnackBar(error);
  }

  @override
  void onUpdateEmployeeSuccess(int value) {
    // TODO: implement onUpdateEmployeeSuccess
    if (value > 0) {
      _getEmployeeResponse.doGet();
      _showSnackBar("data has been saved successfully");
    } else {
      _showSnackBar("Failed, please check dara");
    }
  }
}
