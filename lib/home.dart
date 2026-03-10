import 'package:flutter/material.dart';
import 'package:project1/addnewtask.dart';
import 'package:project1/edittask.dart';
import 'package:project1/homeage.dart';
import 'leadModel.dart';

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true, // Center the title
          title: Text(
            'Customer Profile',
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
              size: 30,
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
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Increased gap for the logo

                  SizedBox(height: 160),

                  // Button 1
                  ElevatedButton(
                    onPressed: () => customer(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background color
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 25),
                      textStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: Color(0xFF432e2d), // Text color: 0xFF432e2d
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), // Rectangular shape
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 10),
                        Text('New Profile'),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  // Button 2
                  ElevatedButton(
                    onPressed: () => customer1(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background color
                      padding:
                          EdgeInsets.symmetric(horizontal: 85, vertical: 25),
                      textStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: Color(0xFF432e2d), // Text color: 0xFF432e2d
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), // Rectangular shape
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 10),
                        Text('Edit Profile'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void customer(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewCustomerPage()),
    );
  }

  void customer1(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPage1(leadModel: LeadModel()),
        ));
  }
}











// This Flutter code represents a HomePage1 widget for a mobile application. It serves as a page where users can interact with customer profiles. Here's a detailed explanation of the code:

// Import Statements:

// The code begins with import statements, where necessary libraries and Dart files are imported. 
//Some of the key imports include:
// flutter/material.dart: This is the Flutter framework's core library for building UI.
// homePage.dart: Importing the HomePage widget, which is the home page of the application.
// leadModel.dart: Importing a lead model, which presumably contains data related to customer profiles.
// customerForm.dart: Importing a form (possibly for creating new customer profiles).
// editPage.dart: Importing an edit page for customer profiles.



// HomePage1 Class:

// This is a StatelessWidget representing the second home page of the mobile application.
// It includes an AppBar with a centered title and a back button (arrow) for navigation
// back to the previous page (HomePage).
// The body of the page is a centered column containing UI elements.
// A text widget displays "Customer Profile" with specific text styling, including a custom font and color.
// There are two elevated buttons:
// "New Profile": This button navigates to a page where users can create a new customer profile.
// It's associated with the customer function.
// "Edit Profile": This button navigates to a page where users can edit an existing customer profile.
// It's associated with the customer1 function.



// _handleLogout Method (Commented Out):

// The _handleLogout method is commented out and appears to be incomplete or not used in this widget.
// It's related to the logout functionality but doesn't have an implementation.



// Navigation Methods:

// There are two methods (customer and customer1) used to navigate to different parts of the app when the respective buttons are pressed.
// customer: Navigates to a page (NewCustomerPage) where users can create a new customer profile.
// customer1: Navigates to a page (EditPage1) where users can edit an existing customer profile.



// UI Elements:

// The UI includes a greeting message ("Customer Profile") with custom text styling.
// Two elevated buttons are provided with icons and text for creating new profiles and editing existing ones.
// Overall, this HomePage1 widget serves as a secondary home page within the mobile app, 
//specifically for interacting with customer profiles.
// Users can create new profiles or edit existing ones, and there is a back button for
// navigation to the main home page (HomePage).




