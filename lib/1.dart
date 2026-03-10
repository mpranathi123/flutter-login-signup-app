import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/edittask.dart';
import 'Employee_controller.dart';
import 'leadModel.dart';
// import 'report.dart';
// import 'package:project1/AdminEnroll.dart';
import 'package:intl/intl.dart';

//import 'package:vikas_bank_demo/editform.dart';
//import 'package:vikas_bank_demo/result.dart';
class NewCustomerPage1 extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  _NewCustomerPage1State createState() => _NewCustomerPage1State();
}

class _NewCustomerPage1State extends State<NewCustomerPage1> {
  final TextEditingController name = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _task = TextEditingController();
  final TextEditingController _Area = TextEditingController();
  final TextEditingController _City = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  final TextEditingController loginid = TextEditingController();
  final TextEditingController createdAT = TextEditingController();
  final TextEditingController _serviceSuggestion = TextEditingController();
  final TextEditingController Amount = TextEditingController();
  final TextEditingController _amountController1 = TextEditingController();
  final TextEditingController _amountController2 = TextEditingController();
  final TextEditingController _amountController3 = TextEditingController();
  final TextEditingController _amountController4 = TextEditingController();
  final TextEditingController _amountController5 = TextEditingController();
  final TextEditingController _amountController6 = TextEditingController();
  final TextEditingController _amountController7 = TextEditingController();
  final TextEditingController _amountController8 = TextEditingController();
  final TextEditingController _amountController9 = TextEditingController();
  final TextEditingController _amountController10 = TextEditingController();
  final TextEditingController _amountController11 = TextEditingController();
  final TextEditingController _amountController12 = TextEditingController();
  final TextEditingController _amountController13 = TextEditingController();
  final TextEditingController _amountController14 = TextEditingController();
  final TextEditingController _amountController15 = TextEditingController();
  final TextEditingController _amountController16 = TextEditingController();
  final TextEditingController _amountController17 = TextEditingController();
  final TextEditingController _amountController18 = TextEditingController();
  final TextEditingController _amountController19 = TextEditingController();
  final TextEditingController _amountController20 = TextEditingController();
  final TextEditingController _amountController21 = TextEditingController();
  final TextEditingController _amountController22 = TextEditingController();

  String customer = '';
  final _formKey = GlobalKey<FormState>();

  // Holds the selected customer value
  String _selectedOccupation = ''; // Holds the selected occupation value
  String _selectedBranch = ''; // Holds the selected branch value
  //String _selectedPlace = ''; // Holds the selected place value
//  String _selectedloan = ''; // Holds the selected place value

  final List<String> _occupationOptions = [
    'Business Entity',
    'House wife',
    'Institution',
    'Salaried',
    'Self Employee',
    'Society',
    'Student',
    'Retired Employees',
    'Farmer',
    'Individual',
  ];
  String? amountError;
  String? checkboxError;
  bool _convert = false;
  @override
  void initState() {
    super.initState();

    Map<String, dynamic> arguments = Get.arguments;

    _selectedOccupation = arguments['Occupation'].toString();
    _selectedBranch = arguments['Reporting_Branch'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent going back
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Center(
              // Center the title text
              child: Text(
                'Edit Form',
                style: TextStyle(
                  color: const Color(0xFFde9c4e),
                  fontFamily: 'Roboto',
                  fontSize: 30,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: const Color(0xFF7d7c4e),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Container(
            color: const Color(0xFFDFE2C7),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Customer Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: name
                      ..text = "${Get.arguments['Name'].toString()}",
                    decoration: InputDecoration(
                      hintText: 'Enter customer name',
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Customer Mobile No:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: _mobileNumber
                      ..text = "${Get.arguments['Mobile'].toString()}",
                    decoration: InputDecoration(
                      hintText: 'Enter customer mobile no',
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  Text(
                    'Task:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto', color: Color(0xFF432e2d),
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _task
                      ..text = "${Get.arguments['Task'].toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  Text(
                    'Area:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto', color: Color(0xFF432e2d),
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _Area
                      ..text = "${Get.arguments['Area'].toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  Text(
                    'City:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto', color: Color(0xFF432e2d),
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _City
                      ..text = "${Get.arguments['City'].toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  Text(
                    'Pincode:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto', color: Color(0xFF432e2d),
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _pincode
                      ..text = "${Get.arguments['Pincode'].toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Profession:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  SizedBox(height: 5),
                  DropdownButton<String>(
                    value: _selectedOccupation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedOccupation = newValue!;
                      });
                    },
                    items: _occupationOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Color(
                                0xFF432e2d), //, fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _submitForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 25),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 233, 228),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // Set the border radius to 0 for a rectangle
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Color(0xFF432e2d),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (name.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Name is required.')),
        );
        return;
      }

      if (_mobileNumber.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mobile number is required.')),
        );
        return;
      }
      if (_mobileNumber.text.length != 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mobile number must be 10 digits.')),
        );
        return;
      }

      _formKey.currentState!.save();
      _navigateToSubmittedPage();
    }
  }

  Future<bool> _checkMobileNumberExists(String mobileNumber) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('task')
          .where('Mobile', isEqualTo: mobileNumber)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking mobile number existence: $e');
      return false;
    }
  }

  void _navigateToSubmittedPage() async {
    if (_formKey.currentState!.validate()) {
      //String documentId = Get.arguments['docId'];
      FirebaseFirestore.instance
          .collection("task")
          .doc("${Get.arguments['docId'].toString()}")
          .update({
        'Name': name.text,
        'Mobile': _mobileNumber.text,
        'Task': _task.text,
        'Area': _Area.text,
        'City': _City.text,
        'Pincode': _pincode.text,
        //'CreatedAt': createdAT.text,
        //'EMobile': loginid.text,
        'Service': _serviceSuggestion.text,

        // Add other fields you want to store
        'Email': EmployeeController().email,
      });

      Get.offAll(() => EditPage1(leadModel: LeadModel()));
    }
  }
}
 

// Let's break down the code step by step:

// 1. Import Statements:
//    - The code begins with import statements that include necessary Flutter and Dart packages like 
//`flutter/material.dart`, `get/get.dart`, and `cloud_firestore.dart`.
// These packages are used for building the user interface, managing state, and interacting
// with Firebase Firestore, respectively.

// 2. Class Definitions:
//    - The code defines a class named `NewCustomerPage1`, which is a StatefulWidget.
//      This widget represents the page where users can edit customer information.

// 3. State Initialization:
//    - Inside the `NewCustomerPage1` class, various state variables and controllers are initialized. 
//      These include controllers for text input fields like name, mobile number, address, etc. 
//      Additionally, there are boolean variables for tracking product and loan preferences,
//       and dropdown menu options for occupation and branch.

// 4. initState Method:
//    - The `initState` method is called when the widget is first created. 
//      In this method, initial values for the form fields and preferences are 
//      set based on the arguments received from the previous screen (using the `Get.arguments` map).

// 5. Build Method:
//    - The `build` method is where the user interface for this page is constructed.
//      It returns a `Scaffold` widget containing an `AppBar` and a `SingleChildScrollView` 
//      that holds various form elements.
//    - The form elements include text input fields for customer name, mobile number, 
//      address components (flat, area, city, pincode), and service suggestion. 
//      There are also dropdown menus for selecting occupation and branch, 
//      as well as checkboxes for product and loan preferences.
//    - At the end of the form, there's an "ElevatedButton" widget that, 
//     when pressed, updates the customer's information in the Firestore database.

// 6. Submit Form Method:
//    - There's a private `_submitForm` method defined,
//      but it's not currently being used in the code.
//      It appears to be intended for form validation and submission, 
//      but it's not connected to any user interaction.

// 7. Update Firestore Data:
//    - Inside the `onPressed` handler of the "Save" button, 
//      Firestore is updated with the edited customer information. 
//      The data is updated based on the changes made by the user in the form fields.

// 8. Navigation:
//    - The code includes navigation logic using the `Get` package.
//      When the "Save" button is pressed, it navigates the user to an `EditPage1` with a `LeadModel`. 
//      The `Get.offAll` method is used for navigation.

// Overall, this code defines a Flutter page for editing customer information and
// updating it in a Firestore database. It also handles user interface elements like text fields,
// dropdown menus, and checkboxes for selecting various options.