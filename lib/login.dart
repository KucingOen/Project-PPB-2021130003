import 'package:flutter/material.dart';
import 'package:task_manager/const/app_color.dart';
import 'package:task_manager/dashboard.dart';
import 'package:task_manager/register.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkPrimaryColor,
          title: const Text('Schedule & Task Manager'),
        ),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: lightPrimaryColor),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 256,
                      width: 256,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image:
                                AssetImage('images/reminder_illustration.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final message = await AuthService().login(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              if (message!.contains('Success')) {
                                // Define the substring you want to start after
                                /*String keyword = "Success.";

                              // Find the index of the keyword and add its length to get the start index
                              int startIndex = message.indexOf(keyword);

                              if (startIndex != -1) {
                                // Use substring to get everything after the keyword
                                String result = message.substring(startIndex + keyword.length).trim();
                                print(result); // Output: "is a Flutter tutorial"
                                // Navigate to the Home page
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashboardPage(username: result, email: emailController.text)),
                                );
                              } else {
                                print("Keyword not found in the text.");
                              }*/

                                Navigator.pushReplacement(
                                  context,
                                  //MaterialPageRoute(builder: (context) => DashboardPage(username: result, email: emailController.text)),
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardPage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill input')),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigate to Register Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Don't have an account? Register"),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
