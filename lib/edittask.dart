import 'package:get/get.dart';
import 'package:project1/edittaskform.dart';
import 'package:project1/home.dart';
import 'Employee_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:uuid/uuid.dart';
import 'leadModel.dart';

//import 'mark_conv.dart';
class EditPage1 extends StatefulWidget {
  final LeadModel leadModel;
  EditPage1({required this.leadModel});
  @override
  _EditPage1State createState() => _EditPage1State();
}

class _EditPage1State extends State<EditPage1> {
  String? selectedCustomerId;

  void _markAsConversion() {
    if (selectedCustomerId != null) {
      setState(() {
        widget.leadModel.conversionsMarked.add(selectedCustomerId!);
        widget.leadModel.numberOfLeadsGenerated =
            widget.leadModel.conversionsMarked.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: const Color(0xFFde9c4e),
              fontFamily: 'Roboto',
              fontSize: 30,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xFF7d7c4e),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage1()),
              );
            },
          ),
        ),
        body: Center(
          child: Container(
              color: const Color(0xFFDFE2C7),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('task')
                          .where('Email', isEqualTo: EmployeeController().email)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("somthing went wrong");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Text("no data");
                        }
                        // ignore: unnecessary_null_comparison
                        if (snapshot != null && snapshot.data != null) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var name = snapshot.data!.docs[index]['Name'];
                                var mobile =
                                    snapshot.data!.docs[index]['Mobile'];
                                var docId = snapshot.data!.docs[index].id;
                                SizedBox(height: 100);
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF7d7c4e),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      mobile,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: const Color(0xFF7d7c4e),
                                      ),
                                    ),
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          VerticalDivider(
                                            width: 1,
                                            thickness: 1,
                                            color: Color.fromARGB(
                                                255, 218, 225, 228),
                                          ),
                                          SizedBox(
                                            width: 13,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Get.to(() => NewCustomerPage1(),
                                                    arguments: {
                                                      'Name': snapshot.data
                                                          ?.docs[index]['Name'],
                                                      'Mobile': snapshot
                                                              .data?.docs[index]
                                                          ['Mobile'],
                                                      'Area': snapshot.data
                                                          ?.docs[index]['Area'],
                                                      'City': snapshot.data
                                                          ?.docs[index]['City'],
                                                      'Pincode': snapshot
                                                              .data?.docs[index]
                                                          ['Pincode'],
                                                      'Service': snapshot
                                                              .data?.docs[index]
                                                          ['Service'],
                                                      'Occupation': snapshot
                                                              .data?.docs[index]
                                                          ['Occupation'],
                                                      'Task': snapshot.data
                                                          ?.docs[index]['Task'],
                                                      'docId': snapshot
                                                          .data?.docs[index].id,
                                                    });
                                              },
                                              child: Icon(Icons.edit,
                                                  color: Color.fromARGB(
                                                      255, 97, 99, 100))),
                                          SizedBox(width: 13),
                                          VerticalDivider(
                                            width: 1,
                                            thickness: 1,
                                            color: Color.fromARGB(
                                                255, 198, 208, 211),
                                          ),
                                          SizedBox(width: 10),
                                          //  SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Do you want to Delete?',
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFF7d7c4e), // Set the text color to blue
                                                        fontSize:
                                                            20, // Set the font size to 25
                                                        //
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "task")
                                                              .doc(docId)
                                                              .delete();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditPage1(
                                                                          leadModel:
                                                                              LeadModel(),
                                                                        )),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                            color: const Color(
                                                                0xFF7d7c4e), // Set the text color to blue
                                                            fontSize:
                                                                20, // Set the font size to 25
                                                            //
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditPage1(
                                                                          leadModel:
                                                                              LeadModel(),
                                                                        )),
                                                          );
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: TextStyle(
                                                            color: const Color(
                                                                0xFF7d7c4e), // Set the text color to blue
                                                            fontSize:
                                                                20, // Set the font size to 25
                                                            //
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 97, 99, 100)),
                                          ),
                                        ]),
                                  ),
                                );
                              });
                        }
                        return Container();
                      }))),
        ));
  }

  Widget _buildSquareButton(BuildContext context, VoidCallback onPressed,
      {IconData? iconData}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData !=
              null) // Conditionally show the icon if iconData is not null
            Icon(iconData, size: 50),
          SizedBox(width: 0), // Adjust spacing between icon and text
          //         Text(buttonText),
        ],
      ),
    );
  }
}











// This code represents a page where users can edit customer profiles 
//and potentially mark them as converted. Here's a breakdown of the code:

// 1. Import Statements:
//    - The code starts with import statements that include various Flutter and Dart packages, 
//      such as `get/get.dart`, `cloud_firestore.dart`, `material.dart`, and `cupertino.dart`.
//      These packages are used for building the user interface, managing state, and interacting with Firebase Firestore.

// 2. Class Definitions:
//    - The code defines a `EditPage1` class, which is a StatefulWidget. 
//      This widget represents the page where customer profiles can be edited.

// 3. Constructor:
//    - The `EditPage1` class has a constructor that accepts a `LeadModel` as a parameter. 
//      This model likely contains information about the leads and conversions.

// 4. State Initialization:
//    - Inside the `_EditPage1State` class, there's a `selectedCustomerId` variable,
//      which is used to store the ID of a selected customer profile. 
//      There's also a `_markAsConversion` method that is intended to mark a customer as converted, 
//      but it's currently not being used.

// 5. Build Method:
//    - The `build` method is where the user interface for this page is constructed.
//      It returns a `Scaffold` widget containing an `AppBar` and a `Container` that wraps a `StreamBuilder`.

//    - The `StreamBuilder` listens to a Firestore collection named 'Bank' and 
//      retrieves documents where the 'Convert' field is set to false and the 'EMobile' field matches the mobile number 
//      from `EmployeeController().mobile`.
//      It then builds a list of customer profiles based on the retrieved data.

//    - The customer profiles are displayed in a `ListView.builder`, 
//      where each profile is represented by a `Card` containing the 
//      customer's name, mobile number, and edit/delete options.

//    - The edit option (`Icon(Icons.edit)`) allows users to navigate
//       to a `NewCustomerPage1` to edit the customer's information.

//    - The delete option (`Icon(Icons.delete)`) opens an AlertDialog 
//      to confirm if the user wants to delete the customer profile.
//      If confirmed, the customer profile is deleted from Firestore.

// 6. `_buildSquareButton` Widget:
//    - This is a custom widget used to build square-shaped buttons with optional icons. 
//      It's not currently being used in the code.

// Overall, this code represents a page where customer profiles can be viewed, edited, 
//and potentially marked as converted. It relies on Firebase Firestore for data storage and retrieval.