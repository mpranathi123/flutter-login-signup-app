import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project1/viewagee.dart';
import 'leadModel.dart';

class NewCustomerPage3 extends StatefulWidget {
  @override
  _NewCustomerPage3State createState() => _NewCustomerPage3State();
}

class _NewCustomerPage3State extends State<NewCustomerPage3> {
  TextEditingController _feedbackController = TextEditingController();
  TextEditingController _feedbackController1 = TextEditingController();
  TextEditingController _feedbackController2 = TextEditingController();
  DateTime _selectedReminderDate = DateTime.now();
  DateFormat _dateFormat = DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timestamp reminderTimestamp0 = Get.arguments['Remainder_date0'];
    Timestamp reminderTimestamp1 = Get.arguments['Remainder_date1'];
    Timestamp reminderTimestamp2 = Get.arguments['Remainder_date2'];

    String reminderDateStr0 = reminderTimestamp0.toDate().toString() ?? '';
    String reminderDateStr1 = reminderTimestamp1.toDate().toString() ?? '';
    String reminderDateStr2 = reminderTimestamp2.toDate().toString() ?? '';

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Center(
            // Center the title text
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
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xFF7d7c4e),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LeadPage1(
                  leadModel: LeadModel(),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: const Color(0xFFDFE2C7),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _feedbackController
                        ..text = "${Get.arguments['Comments0'].toString()}",
                      decoration:
                          InputDecoration(labelText: 'Take away meeting 1'),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _feedbackController1
                        ..text = "${Get.arguments['Comments1'].toString()}",
                      decoration:
                          InputDecoration(labelText: 'Take away meeting 2'),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _feedbackController2
                        ..text = "${Get.arguments['Comments2'].toString()}",
                      decoration:
                          InputDecoration(labelText: 'Take away meeting 3'),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 32),

                    // Display the reminder date
                    Text(
                      'Date For next visit 1: ${_formatReminderDate(reminderDateStr0)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    Text(
                      'Date For next visit 2: ${_formatReminderDate(reminderDateStr1)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                    Text(
                      'Date For next visit 3: ${_formatReminderDate(reminderDateStr2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Color(0xFF432e2d),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  String _formatReminderDate(String dateStr) {
    return _dateFormat.format(DateTime.parse(dateStr));
  }
}
