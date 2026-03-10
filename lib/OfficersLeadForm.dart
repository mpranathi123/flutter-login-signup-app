import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/viewagee.dart';
import 'Employee_controller.dart';
import 'leadModel.dart';
// import 'report.dart';
// import 'package:project1/AdminEnroll.dart';

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
  String customer = '';
  final _formKey = GlobalKey<FormState>();
  // Holds the selected customer value
  String _selectedOccupation = ''; // Holds the selected occupation value

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
                'Lead',
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
                    'Name:',
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
                    'Mobile No:',
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
                  SizedBox(height: 20),
                  Text(
                    'Complete',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xFF432e2d),
                    ),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: _convert,
                    onChanged: (newValue) {
                      setState(() {
                        _convert = newValue!;
                        checkboxError =
                            null; // Clear the error message when the checkbox is checked
                      });
                    },
                  ),
                  if (checkboxError != null)
                    Text(
                      checkboxError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!_convert) {
                          setState(() {
                            checkboxError =
                                ' All the necessary details are required';
                          });
                        } else {
//                         var createdTimestamp = Get.arguments['CreatedAt'];
// var convertedAt = createdTimestamp.toDate();
// var selectedYear = convertedAt.year;
// var selectedMonth = convertedAt.month;

// var formattedDate = DateFormat('MMMM yyyy').format(convertedAt);
//  var selectedMonthDate = DateFormat('MMMM')
//                           .format(convertedAt); // Convert DateTime to formatted string

//                               var _selectedBranch = EmployeeController().branch;

                          FirebaseFirestore.instance
                              .collection("task")
                              .doc("${Get.arguments['docId'].toString()}")
                              .update({
                            'Email': EmployeeController().email,
                            // // Add other fields you want to store
                            'Complete': _convert,
                            'CompletedAt': DateTime.now(),
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LeadPage1(leadModel: LeadModel()),
                              ));
                        }
                      }
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

  Future<int> getConvertedDocumentCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("task")
        .where('Complete', isEqualTo: true)
        .get();

    return querySnapshot.size;
  }
}
