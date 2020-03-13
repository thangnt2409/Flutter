import 'package:crudemployeeapp/models/employee.dart';
import 'dart:async';
import 'package:crudemployeeapp/data/database_helper.dart';

class EmployeeCtr {
DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveEmployee(Employee employee) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("EMPLOYEE", employee.toMap());
    return res;
  }

  //deletion
  Future<int> deleteEmployee(int id) async {
    var dbClient = await con.db;
    int res = await dbClient.rawDelete('DELETE FROM EMPLOYEE WHERE ID = ?', [id]);
    return res;
  }

  Future<int> updateEmployee(int id, String name, String address, int age) async {
    var dbClient = await con.db;
    int res = await dbClient.rawUpdate("UPDATE EMPLOYEE SET ADDRESS = '$address', NAME = '$name', AGE = '$age' WHERE ID = ?", [id]);
    return res;
  }

  Future<Employee> checkEmployee(String name, String address) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM EMPLOYEE WHERE NAME = '$name' and ADDRESS = '$address'");
    
    if (res.length > 0) {
      return new Employee.fromMap(res.first);
    }

    return null;
  }

  Future<List<Employee>> getAllEmployee() async {
    var dbClient = await con.db;
    var res = await dbClient.query("EMPLOYEE");
    
    List<Employee> list =
        res.isNotEmpty ? res.map((c) => Employee.fromMap(c)).toList() : null;

    return list;
  }
}