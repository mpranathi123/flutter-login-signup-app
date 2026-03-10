import 'package:get/get.dart';
import 'package:project1/comment.dart';
import 'package:project1/homeage.dart';
import 'package:project1/visit.dart';
import 'Employee_controller.dart';
import 'OfficersLeadForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'leadModel.dart';
import 'package:intl/intl.dart';

class LeadPage1 extends StatefulWidget {
  final LeadModel leadModel;
  LeadPage1({required this.leadModel});
  @override
  _LeadPage1State createState() => _LeadPage1State();
}

class _LeadPage1State extends State<LeadPage1> {
  static const int maxFollowUpCount = 3;
  String? selectedCustomerId;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> visitInfoList = [];
  List<QueryDocumentSnapshot> searchResults = [];

  void _markAsConversion() {
    if (selectedCustomerId != null) {
      setState(() {
        widget.leadModel.conversionsMarked.add(selectedCustomerId!);
        widget.leadModel.numberOfLeadsGenerated =
            widget.leadModel.conversionsMarked.length;
      });
    }
  }

  Future<void> _loadVisitInfo(String docId) async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection("task").doc(docId).get();

    if (docSnapshot.exists) {
      final visitData = docSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> visits = visitData['Visits'] ?? [];

      setState(() {
        visitInfoList = List<Map<String, dynamic>>.from(visits);
      });
    } else {
      setState(() {
        visitInfoList = [];
      });
    }
  }

  int getLeadSortingOrder(DateTime? remind) {
    if (remind != null) {
      DateTime currentDate = DateTime.now();
      DateTime currentDateWithoutTime =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      DateTime remainderDate = remind;
      DateTime remainderDateWithoutTime =
          DateTime(remainderDate.year, remainderDate.month, remainderDate.day);

      if (remainderDateWithoutTime.isAtSameMomentAs(currentDateWithoutTime)) {
        return 0; // Current date leads
      } else if (remainderDateWithoutTime.isAfter(currentDateWithoutTime)) {
        return 1; // Future date leads
      } else {
        return 2; // Previous date leads
      }
    } else {
      return 2; // Leads with no Remainder_date (assume them as previous date)
    }
  }

  void searchCustomers(String name) {
    FirebaseFirestore.instance
        .collection('task')
        .where('Name', isEqualTo: name)
        .get()
        .then((querySnapshot) {
      setState(() {
        searchResults = querySnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> greenLeads = [];
    List<DocumentSnapshot> yellowLeads = [];
    List<DocumentSnapshot> redLeads = [];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Color.fromRGBO(225, 128, 0, 1.0),
                fontFamily: 'Roboto',
                fontSize: 22,
              ),
              children: [
                TextSpan(
                  text: 'Task',
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.double_arrow_outlined,
                    color: const Color(0xFF7d7c4e),
                    size: 30,
                  ),
                ),
                TextSpan(
                  text: ' Complete',
                ),
              ],
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
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: Container(
            color: const Color(0xFFDFE2C7),
            child: Column(
              children: [
                SizedBox(height: 40),
                Expanded(
                    child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('task')
                          .where('Complete', isEqualTo: false)
                          .where('Email',
                              isEqualTo: EmployeeController()
                                  .email) // Assuming EmployeeController().mobile is accessible and provides the employee's mobile number
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("something went wrong");
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
                        if (snapshot.data != null) {
                          snapshot.data!.docs.forEach((doc) {
                            DateTime? remindDateTime =
                                doc['Remainder_date']?.toDate();
                            int sortingOrder =
                                getLeadSortingOrder(remindDateTime);

                            if (sortingOrder == 0) {
                              greenLeads.add(doc);
                            } else if (sortingOrder == 1) {
                              yellowLeads.add(doc);
                            } else {
                              redLeads.add(doc);
                            }
                          });

                          List<DocumentSnapshot> allLeads = [];
                          allLeads.addAll(greenLeads);
                          allLeads.addAll(yellowLeads);
                          allLeads.addAll(redLeads);

                          // Sort the allLeads list based on the sorting order
                          allLeads.sort((a, b) {
                            DateTime? remindA = a['Remainder_date']?.toDate();
                            DateTime? remindB = b['Remainder_date']?.toDate();
                            int sortingOrderA = getLeadSortingOrder(remindA);
                            int sortingOrderB = getLeadSortingOrder(remindB);

                            // Compare based on sorting order
                            if (sortingOrderA != sortingOrderB) {
                              return sortingOrderA.compareTo(sortingOrderB);
                            } else {
                              // If sorting order is the same, compare based on the actual date
                              if (remindA != null && remindB != null) {
                                return remindA.compareTo(remindB);
                              } else {
                                return 0;
                              }
                            }
                          });

                          return ListView.builder(
                            itemCount: allLeads.length,
                            itemBuilder: (context, index) {
                              // Your existing item builder code
                              var name = allLeads[index]['Name'];
                              var mobile = allLeads[index]['Mobile'];
                              var remind =
                                  allLeads[index]['Remainder_date']?.toDate();
                              var visitCount =
                                  allLeads[index]['Visit'] as int? ?? 0;
                              var isAddButtonEnabled =
                                  visitCount < maxFollowUpCount;
                              var docId = allLeads[index].id;

                              Color? backgroundColor;

                              String remainderDateText;
                              int visitValue = visitCount;

                              if (visitValue == 0) {
                                DateTime currentDate = DateTime.now();
                                DateTime remindDate = remind!;
                                String formattedRemindDate =
                                    DateFormat('yyyy-MM-dd').format(remindDate);
                                String formattedCurrentDate =
                                    DateFormat('yyyy-MM-dd')
                                        .format(currentDate);

                                if (formattedRemindDate ==
                                    formattedCurrentDate) {
                                  remainderDateText = 'Today';
                                  backgroundColor = Color(0xFF818052);
                                } else if (remindDate.isAfter(currentDate)) {
                                  remainderDateText =
                                      'Upcoming Date: $formattedRemindDate';
                                  backgroundColor = Color(0xFFde9c4e);
                                } else {
                                  remainderDateText =
                                      'Unnoticed: $formattedRemindDate';
                                  backgroundColor = Color(0xFFa32b2d);
                                }
                              } else {
                                DateTime currentDate = DateTime.now();
                                DateTime remindDate = snapshot
                                    .data!.docs[index]['Remainder_date0']
                                    .toDate()!;
                                String formattedRemindDate =
                                    DateFormat('yyyy-MM-dd').format(remindDate);
                                String formattedCurrentDate =
                                    DateFormat('yyyy-MM-dd')
                                        .format(currentDate);

                                if (formattedRemindDate ==
                                    formattedCurrentDate) {
                                  remainderDateText = 'Today';
                                  backgroundColor = Color(0xFF818052);
                                } else if (remindDate.isAfter(currentDate)) {
                                  remainderDateText =
                                      'Upcoming Date: $formattedRemindDate';
                                  backgroundColor = Color(0xFFde9c4e);
                                  // }
                                } else {
                                  remainderDateText =
                                      'Unnoticed: $formattedRemindDate';
                                  backgroundColor = Color(0xFFa32b2d);
                                }
                              }
                              SizedBox(height: 100);
                              return Card(
                                color: backgroundColor,
                                child: ListTile(
                                  title: Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontWeight: FontWeight
                                          .bold, // Add fontWeight here
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mobile,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        remainderDateText,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (isAddButtonEnabled) {
                                            Get.to(() => NewCustomerPage2(),
                                                arguments: {
                                                  'Visit': snapshot.data!
                                                      .docs[index]['Visit'],
                                                  'docId': snapshot
                                                      .data!.docs[index].id,
                                                });
                                          } else {
                                            //_loadVisitInfo(docId);
                                            Get.to(() => NewCustomerPage3(),
                                                arguments: {
                                                  'Comments0': snapshot.data!
                                                      .docs[index]['Comments0'],
                                                  'Comments1': snapshot.data!
                                                      .docs[index]['Comments1'],
                                                  'Comments2': snapshot.data!
                                                      .docs[index]['Comments2'],
                                                  'Remainder_date0':
                                                      snapshot.data!.docs[index]
                                                          ['Remainder_date0'],
                                                  'Remainder_date1':
                                                      snapshot.data!.docs[index]
                                                          ['Remainder_date1'],
                                                  'Remainder_date2':
                                                      snapshot.data!.docs[index]
                                                          ['Remainder_date2'],
                                                  'docId': snapshot
                                                      .data!.docs[index].id,
                                                });
                                          }
                                        },
                                        child: Text(
                                          'Follow UP',
                                          style: TextStyle(
                                            color: isAddButtonEnabled
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 13),
                                      VerticalDivider(
                                        width: 1,
                                        thickness: 1,
                                        color:
                                            Color.fromARGB(255, 244, 246, 247),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => NewCustomerPage1(),
                                              arguments: {
                                                'customerName': snapshot
                                                    .data?.docs[index]['Name'],
                                                'Mobile': snapshot.data
                                                    ?.docs[index]['Mobile'],
                                                'Task': snapshot
                                                    .data?.docs[index]['Task'],
                                                'City': snapshot
                                                    .data?.docs[index]['City'],
                                                'Pincode': snapshot.data
                                                    ?.docs[index]['Pincode'],
                                                'Area': snapshot
                                                    .data?.docs[index]['Area'],
                                                'Occupation': snapshot.data
                                                    ?.docs[index]['Occupation'],
                                                'CreatedAt': snapshot.data
                                                    ?.docs[index]['CreatedAt'],
                                                'docId': snapshot
                                                    .data?.docs[index].id,
                                              });
                                        },
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          color: Color.fromARGB(
                                              255, 245, 250, 245),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ))
              ],
            )));
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
            Icon(iconData, size: 24),
          SizedBox(width: 8), // Adjust spacing between icon and text
        ],
      ),
    );
  }
}
