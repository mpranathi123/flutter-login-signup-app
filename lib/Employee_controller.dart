import 'package:get/get.dart';

class EmployeeController extends GetxController {
  static final EmployeeController _instance = EmployeeController._internal();

  factory EmployeeController() {
    return _instance;
  }

  EmployeeController._internal();
  String name = '';
  String email = '';
  String role = ''; // Add role property
  String branch = ''; // Add branch property
  String id = '';
  void setRole(String value) {
    role = value;
  }

  String getRole() {
    return role;
  }

  void setName(String value) {
    name = value;
  }

  String getName() {
    return name;
  }

  void setid(String value) {
    id = value;
  }

  String getid() {
    return id;
  }

  void setBranch(String value) {
    branch = value;
  }

  String getBranch() {
    return branch;
  }

  init() {}
}
