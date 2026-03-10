import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project1/viewagee.dart';
import 'Employee_controller.dart';
// import 'LeadPage.dart';
import 'leadModel.dart';

class NewCustomerPage2 extends StatefulWidget {
  @override
  _NewCustomerPage2State createState() => _NewCustomerPage2State();
}

class _NewCustomerPage2State extends State<NewCustomerPage2> {
  TextEditingController _feedbackController = TextEditingController();
  DateTime _selectedReminderDate = DateTime.now();
  DateFormat _dateFormat = DateFormat('dd-MM-yyyy hh:mm a');
  List<VisitData> visitsData = [];
  final _formKey = GlobalKey<FormState>(); // Add a form key

  @override
  void initState() {
    super.initState();
    // Call _fetchVisitData when the page is initialized
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
            automaticallyImplyLeading: false,
            centerTitle: true, // Remove the default back button
            title: Center(
              child: Text(
                'Visit',
                style: TextStyle(
                  color: const Color(0xFFde9c4e),
                  fontFamily: 'Roboto',
                  fontSize: 30,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Go back to the lead page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeadPage1(
                      leadModel: LeadModel(),
                    ),
                  ),
                );
              },
            ),
          ),
          body: Container(
            color: const Color(0xFFDFE2C7),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey, // Assign the form key
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _feedbackController,
                        decoration:
                            InputDecoration(labelText: 'Meeting Takeaways'),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Color(0xFF432e2d),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Meeting Takeaways is required';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Date For New Revisit',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          color: Color(0xFF432e2d),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectReminderDate(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: _formatReminderDate(_selectedReminderDate),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              color: Color(0xFF432e2d),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, save the visit
                            _saveVisit();
                            _fetchVisitData();
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeadPage1(
                                    leadModel: LeadModel(),
                                  ),
                                ),
                              );
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 25),
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
                          'Save Visit',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Color(0xFF432e2d),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      if (visitsData.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Visits:',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                color: Color(0xFF432e2d),
                              ),
                            ),
                            for (var visit in visitsData)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Visit ${visit.visitNumber}:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF432e2d),
                                    ),
                                  ),
                                  Text(
                                    'Date: ${_dateFormat.format(visit.date.toDate())}', // Format the timestamp as a date
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF432e2d),
                                    ),
                                  ),
                                  Text(
                                    'Meeting Takeaway: ${visit.comments}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF432e2d),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
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

  void _saveVisit() {
    // Fetch the visit number from the database
    int visitNumber = Get.arguments['Visit'];

    final comments = _feedbackController.text;
    final date = Timestamp.fromDate(_selectedReminderDate);

    // Save visit data to Firestore within the "Bank" document
    FirebaseFirestore.instance
        .collection("task")
        .doc("${Get.arguments['docId'].toString()}")
        .update({
      'Visit': FieldValue.increment(1),
      'Email': EmployeeController().email,
      'Comments$visitNumber': comments,
      'Remainder_date$visitNumber':
          date, // Saving the remainder date as a timestamp
      'Convert': false,
    }).then((_) {
      // Clear input fields
      _feedbackController.clear();
      _selectedReminderDate = DateTime.now();

      // Update the UI
      setState(() {});
    }).catchError((error) {
      // Handle error here
      print("Error: $error");
    });
  }

  void _fetchVisitData() {
    String docId = Get.arguments['docId'].toString();

    FirebaseFirestore.instance.collection("task").doc(docId).get().then((doc) {
      if (doc.exists) {
        // Retrieve visit data from Firestore
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        setState(() {
          visitsData.clear();
          for (int visitNumber = 0; visitNumber <= 3; visitNumber++) {
            String commentsKey = 'Comments$visitNumber';
            String dateKey = 'Remainder_date$visitNumber';

            if (data.containsKey(commentsKey) && data.containsKey(dateKey)) {
              String comments = data[commentsKey];
              Timestamp timestamp = data[dateKey]; // Retrieve the timestamp

              // Create VisitData objects and add them to the list
              visitsData.add(VisitData(visitNumber, comments, timestamp));
            }
          }
        });
      } else {
        // Handle case where document does not exist
        print("Document does not exist");
      }
    }).catchError((error) {
      // Handle error
      print("Error fetching document: $error");
    });
  }
}

class VisitData {
  final int visitNumber;
  final String comments;
  final Timestamp date; // Store the date as a Timestamp

  VisitData(this.visitNumber, this.comments, this.date);
}









// This code represents a Flutter page (`NewCustomerPage2`) for adding and displaying visit data for a customer.
// The code interacts with Firebase Firestore for data storage and retrieval. 
//Let's break down the code step by step:

// 1. **Imports**:
//    - The code imports various Flutter and Firebase packages, including `cloud_firestore`
//      for Firestore database interaction.

// 2. **Class Definition (`NewCustomerPage2`)**:
//    - This code defines a `NewCustomerPage2` class, which is a `StatefulWidget`.

// 3. **State Class (`_NewCustomerPage2State`)**:
//    - This class extends `State<NewCustomerPage2>` and represents the state for the `NewCustomerPage2` widget.

// 4. **State Initialization**:
//    - Inside the `_NewCustomerPage2State` class, there's an initialization of variables,
//      including a text controller for feedback, a `DateTime` for selecting a reminder date, 
//      a `DateFormat` for formatting dates, and a list to store visit data.

// 5. **Build Method**:
//    - The `build` method is the entry point for building the UI of this widget.
//    - It constructs a `Scaffold` with an `AppBar` and a back button for 
//      navigating back to the lead page (`LeadPage1`).
//    - Inside the `Scaffold`, there's a `Form` widget that contains various input fields and buttons.

// 6. **Form Key**:
//    - A form key (`_formKey`) is created and assigned to the `Form` widget.
//      This key is used for form validation.

// 7. **Text Form Fields**:
//    - There's a `TextFormField` for entering meeting takeaways. 
//      It includes validation to ensure that the field is not empty.
//    - Below that, there's a section for selecting a date for a new revisit. 
//      It includes a `TextFormField` that displays the selected date and time when tapped. 
//      The user can select a date and time using `showDatePicker` and `showTimePicker`.

// 8. **Elevated Button**:
//    - An `ElevatedButton` is used to save the visit data. 
//     It performs validation using the form key and, if valid, saves the visit data to Firestore. 
//     After saving, it clears the input fields and updates the UI.

// 9. **Display Visit Data**:
//    - If there is visit data available (`visitsData` is not empty), 
//      it displays a list of visits with visit numbers, dates, and meeting takeaways.

// 10. **Date Formatting and Picker Methods**:
//     - `_selectReminderDate`: Opens date and time pickers to select a reminder date and time.
//     - `_formatReminderDate`: Formats a `DateTime` object as a string.

// 11. **Save Visit Method (`_saveVisit`)**:
//     - This method saves the visit data to Firestore.
//     - It fetches the visit number from the database.
//     - It updates the Firestore document with the meeting takeaways,
//       reminder date (as a timestamp), and sets 'Convert' to `false`.

// 12. **Fetch Visit Data Method (`_fetchVisitData`)**:
//     - This method retrieves visit data from Firestore.
//     - It retrieves visit comments and timestamps from Firestore 
//      and populates the `visitsData` list with `VisitData` objects.

// 13. **VisitData Class**:
//     - This class represents the data structure for visit data.
//     - It includes properties for visit number, comments, and date (stored as a `Timestamp`).

// In summary, this code represents a Flutter screen (`NewCustomerPage2`) 
//for adding and displaying visit data for a customer. 
//It allows users to input meeting takeaways and select a reminder date and time for a revisit. 
//The visit data is stored and retrieved from Firestore, and it displays the history of visits for the customer.