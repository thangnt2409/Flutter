class Employee{
  int _id;
  String _name;
  String _address;
  int _age;

  Employee(this._name, this._address, this._age);

  Employee.fromMap(dynamic obj){
    this._id = obj['ID'];
    this._name = obj['NAME'];
    this._address = obj['ADDRESS'];
    this._age = obj['AGE'];
  }

  Employee.fromObject(dynamic obj){
    this._id = obj._id;
    this._name = obj._name;
    this._address = obj._address;
    this._age = obj._age;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["ID"] = _id;
    map["NAME"] = _name;
    map["ADDRESS"] = _address;
    map["AGE"] = _age;
    return map;
  }

  int get id => _id;
  String get name => _name;
  String get address => _address;
  int get age => _age;

  set age(int value) {
    _age = value;
  }

  set address(String value) {
    _address = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(int value) {
    _id = value;
  }


}