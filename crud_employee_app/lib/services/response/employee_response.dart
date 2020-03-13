
import 'package:crudemployeeapp/models/employee.dart';
import 'package:crudemployeeapp/services/request/employee_request.dart';

abstract class CreateEmployeeCallBack {
  void onCreateEmployeeSuccess(int value);
  void onCreateEmployeeError(String error);
}

abstract class UpdateEmployeeCallBack {
  void onUpdateEmployeeSuccess(int value);
  void onUpdateEmployeeError(String error);
}

abstract class DeleteEmployeeCallBack {
  void onDeleteEmployeeSuccess(int value);
  void onDeleteEmployeeError(String error);
}

abstract class GetEmployeeCallBack {
  void onGetEmployeeSuccess(List<Employee> employees);
  void onGetEmployeeError(String error);
}

class CreateEmployeeResponse{
  CreateEmployeeCallBack _createEmployeeCallBack;
  CreateEmployeeResponse(this._createEmployeeCallBack);
  EmployeeRequest employeeRequest = new EmployeeRequest();

  doCreate(Employee employee){
    employeeRequest
        .saveEmployee(employee)
        .then((value) => _createEmployeeCallBack.onCreateEmployeeSuccess(value))
        .catchError((onError) => _createEmployeeCallBack.onCreateEmployeeError(onError.toString()));
  }
}

class UpdateEmployeeResponse{
  EmployeeRequest employeeRequest = new EmployeeRequest();
  UpdateEmployeeCallBack _updateEmployeeCallBack;
  UpdateEmployeeResponse(this._updateEmployeeCallBack);

  doUpdate(Employee employee){
    employeeRequest
        .updateEmployee(employee).then((value) => _updateEmployeeCallBack.onUpdateEmployeeSuccess(value))
        .catchError((onError)=> _updateEmployeeCallBack.onUpdateEmployeeError(onError.toString()));
  }
}

class DeleteEmployeeResponse{
  EmployeeRequest employeeRequest = new EmployeeRequest();
  DeleteEmployeeCallBack _deleteEmployeeCallBack;
  DeleteEmployeeResponse(this._deleteEmployeeCallBack);

  doDelete(int id){
    employeeRequest.deleteEmployee(id)
        .then((value) => _deleteEmployeeCallBack.onDeleteEmployeeSuccess(value))
        .catchError((onError)=> _deleteEmployeeCallBack.onDeleteEmployeeError(onError.toString()));
  }
}

class GetEmployeeResponse{
  EmployeeRequest employeeRequest = new EmployeeRequest();
  GetEmployeeCallBack _getEmployeeCallBack;
  GetEmployeeResponse(this._getEmployeeCallBack);

  doGet(){
    employeeRequest.getAllEmployee()
        .then((employees) => _getEmployeeCallBack.onGetEmployeeSuccess(employees))
        .catchError((onError)=> _getEmployeeCallBack.onGetEmployeeError(onError.toString()));
  }
}