import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/homeage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'Employee_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class NewCustomerPage extends StatefulWidget {
  @override
  final _formKey = GlobalKey<FormState>();
  _NewCustomerPageState createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _area = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  final TextEditingController _task = TextEditingController();
  String _occupation = "Business Entity";
  final TextEditingController _serviceSuggestion = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedReminderDate = DateTime.now();
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
  DateFormat _dateFormat = DateFormat('dd-MM-yyyy hh:mm a');
  String? checkboxError;
  bool _positive = false;
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
            title: Text(
              'Customer Profile',
              style: TextStyle(
                color: const Color(0xFFde9c4e),
                // fontWeight: FontWeight.bold, // Set the font weight to bold
                fontSize: 25, // Set the font size to 30
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
            color: Color(0xFFdfe2c7), // Set the background color here
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'Name ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red, // Set the color of the asterisk
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      controller: name,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                      textCapitalization: TextCapitalization
                          .words, // Automatically capitalize first letter of each word
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required.';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Mobile',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red, // Set the color of the asterisk
                        fontSize: 16,
                      ),
                    ),
                    //SizedBox(height: 20),
                    TextFormField(
                      controller: _mobileNumber,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF432e2d),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) return 'Mobile number is required.';
                        if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                          return 'Please enter a valid Indian mobile number.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Profession',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red, // Set the color of the asterisk
                        fontSize: 16,
                      ),
                    ),
                    //SizedBox(height: 20),
                    DropdownButtonFormField(
                      items: _occupationOptions.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                color: Color(0xFF432e2d),
                              )),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _occupation = value.toString();
                        });
                      },
                      initialValue: _occupation.isEmpty ? null : _occupation,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Address ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Area ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    //SizedBox(height: 5),
                    TextFormField(
                      controller: _area,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'City ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    //SizedBox(height: 5),
                    TextFormField(
                      controller: _city,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Pincode ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    //SizedBox(height: 5),
                    TextFormField(
                      controller: _pincode,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Task',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    //SizedBox(height: 5),
                    TextFormField(
                      controller: _task,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Service Suggestion ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    TextFormField(
                      controller: _serviceSuggestion,
                      maxLength: 50,
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Date To Remind ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectReminderDate(
                            context); // Show the date and time picker
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: _formatReminderDate(_selectedReminderDate),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32),
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
            ),
          )),
    );
  }

  Future<void> _selectReminderDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedReminderDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedReminderDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  String _formatReminderDate(DateTime date) {
    return _dateFormat.format(date);
  }

  int count = 0;
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

      bool mobileExists = await _checkMobileNumberExists(_mobileNumber.text);

      if (mobileExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mobile number already exists.')),
        );
      } else {
        _formKey.currentState!.save();
        _showConfirmationDialog();
      }
    }
  }

  Future<void> _updateEmployeeBranch(String employeeMobile) async {
    try {
      final employeeRef = FirebaseFirestore.instance
          .collection("task")
          .doc(EmployeeController().id);
    } catch (e) {
      print('Error updating employee branch: $e');
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Do you want to submit?',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
              color: Color(0xFF432e2d),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Close the dialog
                await _updateEmployeeBranch(EmployeeController().email);
                _navigateToSubmittedPage();
                _showSnackBar("successful");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: Color(0xFF432e2d),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSubmittedPage() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, save data to Firestore
      try {
        // Fetch data from the source collection
        //QuerySnapshot sourceSnapshot =
        //  await FirebaseFirestore.instance.collection('Employee').get();

        List<Map<String, dynamic>> newDataList = [];
        // Position? location = await _requestLocationPermission();
        // Extract relevant data from the source collection's documents
        //sourceSnapshot.docs.forEach((sourceDocument) {
        newDataList.add({
          'Email': EmployeeController().email,

          'Name': name.text,
          'Mobile': _mobileNumber.text,
          'Area': _area.text,
          'City': _city.text,
          'Occupation': _occupation,
          'Pincode': _pincode.text,
          'Task': _task.text,
          'Service': _serviceSuggestion.text,
          //      'LoginId':loginId,
          'CreatedAt': DateTime.now(),
          // 'Loan': _selectedLoan,
          'Remainder_date': Timestamp.fromDate(_selectedReminderDate),
          'Complete': false,
          'Visit': 0,
          'Positive_Response': _positive,

          // 'Latitude':
          // location?.latitude ?? 0.0, // Update with the latitude obtained
          // 'Longitude':
          // location?.longitude ?? 0.0, // Update with the longitude obtained
          // Add other fields you want to store
        });
        // Store the extracted data in the destination collection
        WriteBatch batch = FirebaseFirestore.instance.batch();
        newDataList.forEach((newData) {
          batch.set(
            FirebaseFirestore.instance.collection('task').doc(),
            newData,
          );
        });
        await batch.commit();
      } catch (e) {
        print('Error fetching or storing data: $e');
      }
    }
  }

  Future<Position?> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      print('Location permission denied');
    }
    return null;
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      final Geolocator geolocator = Geolocator();
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}







// This Flutter code represents a `NewCustomerPage` widget for a mobile application. 
//This page is used to collect and save customer profile information to a Firestore database.
// Below is a detailed explanation of the code:

// 1. Import Statements:
//    - The code begins with import statements, where necessary libraries and Dart files are imported. 
//Some key imports include:
//      - `cloud_firestore.dart`: This is used for interacting with Firebase Firestore, a NoSQL cloud database.
//      - `intl.dart`: This package provides internationalization and localization support.
//      - `uuid.dart`: It is used to generate universally unique identifiers (UUIDs).
//      - Various other Flutter and custom imports related to UI elements and logic.

// 2. `NewCustomerPage` Class:
//    - This is a `StatefulWidget` representing the page where users can create a new customer profile.
//    - The class has several instance variables to hold the user's input data and selections, 
//      such as name, mobile number, occupation, branch, and product selection.
//    - It uses a `GlobalKey<FormState>` for form validation.
//    - The class also defines lists of occupation options, branch options, and selected products (checkboxes).

// 3. `build` Method:
//    - The `build` method defines the layout and UI elements for the `NewCustomerPage`.
//    - It includes an `AppBar` with a centered title, a back button for navigation, and a form for user input.
//    - The form includes various `TextFormField` and `DropdownButtonFormField` widgets for collecting user information.
//    - It provides checkboxes for selecting one or more products and loans.
//    - A date and time picker are available for setting a reminder date.

// 4. `_handleProductSelection` and `_handleLoanSelection` Methods:
//    - These methods are used to handle the selection of products and loans using checkboxes.
//    - `_handleProductSelection` limits the selection to a maximum of 3 products.

// 5. `_selectReminderDate` Method:
//    - This method displays a date and time picker dialog to choose a reminder date.

// 6. `_formatReminderDate` Method:
//    - This method formats the selected reminder date and time into a specific format (dd-MM-yyyy hh:mm a).

// 7. `_submitForm` Method:
//    - This method is called when the user clicks the "Save" button.
//    - It validates the form fields, checks if the mobile number already exists in the Firestore database, 
//      and shows appropriate error messages.
//    - If validation passes and the mobile number is unique, it displays a confirmation dialog.

// 8. `_checkMobileNumberExists` Method:
//    - This asynchronous method checks whether a mobile number already exists in the Firestore database.

// 9. `_showConfirmationDialog` Method:
//    - This method displays a confirmation dialog when the user intends to submit the form.

// 10. `_navigateToSubmittedPage` Method:
//     - This method is called when the user confirms the submission.
//     - It creates a new customer profile document in Firestore using the collected data.

// 11. `_showSnackBar` Method:
//     - This method displays a snackbar with a provided message at the bottom of the screen.

// Overall, the `NewCustomerPage` is a form-based page that allows users to input customer profile information,
// select products and loans, set a reminder date, and save the data to a Firestore database after validation.