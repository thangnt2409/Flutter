

import 'package:crudemployeeapp/data/query/employee_ctr.dart';
import 'package:crudemployeeapp/models/employee.dart';

class EmployeeRequest{
  EmployeeCtr employeeCtr = new EmployeeCtr();

  Future<int> saveEmployee(Employee employee){
    return employeeCtr.saveEmployee(employee);
  }

  Future<int>updateEmployee(Employee employee){
    return employeeCtr.updateEmployee(employee.id, employee.name, employee.address, employee.age);
  }

  Future<int> deleteEmployee(int id){
    return employeeCtr.deleteEmployee(id);
  }

  Future<List<Employee>> getAllEmployee(){
    return employeeCtr.getAllEmployee();
  }
}