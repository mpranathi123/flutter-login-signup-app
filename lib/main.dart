import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/homeage.dart';
import 'Employee_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBCpdMdLe0zYSwSiF0rPSMhuG6jjih03dI",
      appId: "1:913732058818:android:90e6a7a5566c2f4d84055b",
      messagingSenderId: "913732058818",
      projectId: "task-458c0",
    ),
  );
  await initServices();
  runApp(const MyApp());
}

// Function to initialize GetX services
Future<void> initServices() async {
  // Bind the EmployeeIdController and initialize it
  Get.put<EmployeeController>(EmployeeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Anveshana',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF7d7c4e),
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //  final TextEditingController _confirmPasswordController =
  //     TextEditingController(); // Add this controller
  //      final TextEditingController _newPasswordController =
  //     TextEditingController(); // Add this controller
  String loginstatus = "";
  bool _isPasswordVisible = false;
  // bool _issetPasswordVisible = false;
  // bool _isconfirmPasswordVisible = false;

  Color loginStatusColor =
      Colors.black; // Default color for the login status message

  Future<bool> checkLoginIdExists(String mobile) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('login')
          .where('Email', isEqualTo: mobile)
          .get();
      EmployeeController().email = mobile;
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking login ID: $e');
      return false;
    }
  }

  Future<String?> getPasswordForMobile(String mobile) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('login')
          .where('Email', isEqualTo: mobile)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['Password'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting password: $e');
      return null;
    }
  }

  Future<String?> getUserNameForMobile(String mobile) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('login')
          .where('Email', isEqualTo: mobile)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['Email'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user name: $e');
      return null;
    }
  }

  Future<void> _handleSignUp(BuildContext context) async {
    final String email = _loginidController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        loginstatus = "Email and Password required";
        loginStatusColor = Colors.red;
      });
      return;
    }

    try {
      // Check if email already exists
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('login')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          loginstatus = "Account already exists";
          loginStatusColor = Colors.red;
        });
        return;
      }

      // Create new user document
      await FirebaseFirestore.instance.collection('login').add({
        'Email': email,
        'Password': password,
      });

      setState(() {
        loginstatus = "Sign Up Successful";
        loginStatusColor = Colors.green;
      });

      // Navigate to home or show success dialog
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      setState(() {
        loginstatus = "Error during sign up";
        loginStatusColor = Colors.red;
      });
      print("Sign Up Error: $e");
    }
  }

  void _handleLogin(BuildContext context) async {
    final String email = _loginidController.text.trim();
    final String password =
        _passwordController.text.trim(); // Get entered password

    if (email.isEmpty) {
      setState(() {
        loginstatus = "Enter Correct Id";
        loginStatusColor = Colors.red; // Set the color for failed login
      });
      return;
    }
    bool loginIdExists = await checkLoginIdExists(email);
    if (!loginIdExists) {
      setState(() {
        loginstatus = "Login Failed";
        loginStatusColor = Colors.red; // Set the color for failed login
      });
      return;
    }
    String? storedPassword = await getPasswordForMobile(email);
    if ((password.length != 6 && storedPassword != password)) {
      setState(() {
        loginstatus = "Login Failed, Incorrect Password";
        loginStatusColor = Colors.red; // Set the color for failed login
      });
      return;
    } else {
      String? mobile = await getUserNameForMobile(email);
      setState(() {
        loginstatus = "Login Successful";
        loginStatusColor = const Color.fromARGB(255, 48, 155, 51);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      });
      // Delayed navigation to the appropriate page based on role and branch
      // Show dialog for 6-digit PIN
    }
  }

  Widget _buildPasswordInput(
    TextEditingController controller,
    bool isVisible,
    String labelText,
  ) {
    return Container(
      width: 270,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: IconButton(
            onPressed: () {
              // Toggle visibility
              isVisible = !isVisible;
            },
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        obscureText: !isVisible,
        validator: (value) {
          if (value!.isEmpty) return 'Password is required.';
          if (value.length != 4 || int.tryParse(value) == null) {
            return 'Please enter a 4-digit numeric password.';
          }
          return null;
        },
      ),
    );
  }

  void _submit(
      BuildContext context, String newPassword, String ConfirmPassword) async {
    try {
      String loginId = EmployeeController().id;

      if (loginId.isNotEmpty) {
        if (newPassword == ConfirmPassword) {
          await FirebaseFirestore.instance
              .collection("login")
              .doc(loginId)
              .update({'Password': newPassword});

          // Navigate to the home page after successful update
        }
      }
    } catch (e) {
      // Handle Firestore update error
      print("Firestore Update Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.25;
    return WillPopScope(
        onWillPop: () async {
          // Return false to prevent going back
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              // Ensures scrolling when keyboard opens
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center, // Center vertically
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 270,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _loginidController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Login Id',
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: 270,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                        ),
                      ),
                      SizedBox(height: 25),

                      // Login + Sign Up buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => _handleLogin(context),
                            child: Text("Login"),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () => _handleSignUp(context),
                            child: Text("Sign Up"),
                          ),
                        ],
                      ),

                      SizedBox(
                          height: 10), // Add some space for the status message
                      Text(
                        loginstatus,
                        style: TextStyle(
                          color: loginStatusColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
