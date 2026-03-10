import 'package:flutter/material.dart';
import 'package:project1/home.dart';
import 'package:project1/viewagee.dart';
import 'Employee_controller.dart';
// //import 'lead_page.dart';
// //import 'mark_conv.dart';
import 'leadModel.dart';
import 'main.dart';
// import 'report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'main.dart';
import 'package:url_launcher/url_launcher.dart';

class HorizontalDivider extends StatelessWidget {
  final double width;
  final double thickness;
  final Color color;

  const HorizontalDivider({
    required this.width,
    required this.thickness,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: thickness,
      color: color,
    );
  }
}

class HomePage extends StatelessWidget {
  var numberOfLeadsGenerated;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Color> _getNotificationColor() async {
    // Replace 'employeeId' with the actual employee ID you are using in Firestore
    var loginId = EmployeeController().id;
    // Fetch the Employee document from Firestore
    var snapshot = await _firestore.collection('login').doc(loginId).get();
    // Get the value of the target field (replace 'targetField' with the actual field)
    if (snapshot.exists && snapshot.data()!.containsKey('Target')) {
      var targetField = snapshot['Target'];
      // Determine the color based on the target field value
      return targetField ? Colors.green : Colors.grey;
    } else {
      return Colors.grey; // Change this to your default color
    }
  }

  void _handleLogout(BuildContext context) {
    // Implement logout logic here if required
    // Navigate back to the previous screen (Login Page)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Do you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Implement logout logic here if required
                // Navigate back to the previous screen (Login Page)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          // Center the title text
          child: Text(
            'Namaste ${EmployeeController().email}',
            style: TextStyle(
              color: const Color(0xFFde9c4e),
              fontFamily: 'Roboto',
              fontSize: 30,
            ),
          ),
        ),
        leading: Icon(
          Icons.home,
          color: const Color(0xFF7D7C4E),
          size: 30,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: const Color(0xFF7D7C4E),
              size: 30,
            ),
            onPressed: () {
              _handleLogout(context);
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFDFE2C7), // Set the background color here
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => customer(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White background color
                    padding: EdgeInsets.symmetric(horizontal: 53, vertical: 30),
                    textStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: const Color(0xFF), // Text color
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(0), // Rectangular shape
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_add_outlined),
                      SizedBox(width: 10),
                      Text('New Task'),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => customer1(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    textStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: const Color(0xFF7D7C4E), // Text color
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(0), // Rectangular shape
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.groups_sharp),
                      SizedBox(width: 10),
                      Text('View Task'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void customer(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage1()),
    );
  }

  void customer1(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeadPage1(leadModel: LeadModel()),
        ));
  }
}

Future<void> _launchUrl(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    throw Exception('Could not launch $url');
  }
}
// This Flutter code represents a `HomePage` widget for a mobile application.
// Here's an explanation of the code:

// 1. Import Statements:
//    - Import statements are used to include necessary libraries and other Dart files required for this widget.

// 2. `HomePage` Class:
//    - This is a `StatelessWidget` representing the home page of the mobile application.
//    - It includes a variety of UI elements and buttons to navigate to different parts of the app.
//    - The `AppBar` is a top app bar containing a home icon, notification icon, and logout icon.
//       Each of these icons has `IconButton` widgets with corresponding actions.
//    - The body of the page contains a centered column with several UI elements,
//      including a greeting message, buttons for different actions, and their corresponding handlers.

// 3. `_handleLogout` Method:
//    - This method is intended to handle the logout action. However, it currently lacks implementation comments.
//    - It could be used to perform a logout action, such as clearing user session data,
//      and then navigating back to the login page.

// 4. UI Elements:
//    - The UI includes a greeting message, which displays "Namaste" in a specific style.
//    - There are several elevated buttons with icons and text,
//      each of which is associated with a specific action:
//      - "Customer Profile": Navigates to the `HomePage1` widget.
//      - "Leads": Navigates to the `LeadPage1` widget.
//      - "Reports": Navigates to a reports-related widget.
//      - "Add on": Navigates to an add-on page.
//      - "Feedback": Navigates to a feedback page.

// 5. Navigation Methods:
//    - There are several methods (e.g., `customer`, `customer1`, `customer2`, `customer3`, `customer4`)
//      that handle navigation to different parts of the app when the respective buttons are pressed.

// Overall, this `HomePage` widget provides users with a main dashboard from
// which they can access various sections of the application, such as
//customer profiles, leads, reports, add-ons, and feedback.
//The app also includes a notification feature and a logout option in the app bar.
