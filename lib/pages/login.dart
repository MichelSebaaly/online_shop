import 'package:flutter/material.dart';
import 'main_home_page.dart';
import 'signup.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLoggedin = false;
  bool get isLoggedIn => isLoggedin;
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passwordctrl = TextEditingController();
  final _key = GlobalKey<FormState>();

  void login() async {
    try {
      if (_key.currentState!.validate()) {
        var url = Uri.parse("http://192.168.56.1/online_Shop/login.php");
        var data = {
          "email": emailctrl.text,
          "password": passwordctrl.text,
        };

        var response = await http.post(url, body: data);//
        if (response.statusCode == 200) {
          // Parse the JSON response
          print(response.body);
          var responseData = jsonDecode(response.body);
          if (responseData["status"] == "NotFound") {
            Fluttertoast.showToast(
              msg: "Don't have an account. Create an account",
              toastLength: Toast.LENGTH_SHORT,
            );
            print(responseData);
          } else if (responseData["status"] == "wrongPass") {
            Fluttertoast.showToast(
              msg: "Incorrect password",
              toastLength: Toast.LENGTH_SHORT,
            );
            print(responseData);
          } else if (responseData["status"] == "success") {
            // Successful login
            print(responseData);

            // Update the state indicating the user is logged in
            setState(() {
              isLoggedin = true;
            });

            // Navigate to the home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainHomePage(isLoggedin: isLoggedin,)),
            );
          }
        }
      }
    } catch (e) {
      print("error $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  child: TextFormField(
                    controller: emailctrl,
                    validator: (e) =>
                        e!.isEmpty ? "please specify this field" : null,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ),
                        labelText: "email",
                        hintText: "example@gmail.com"),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: passwordctrl,
                    validator: (e) =>
                        e!.isEmpty ? "please specify this field" : null,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.phone_locked_outlined,
                            size: 30,
                          ),
                        ),
                        labelText: "Password",
                        hintText: "username"),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black, onPrimary: Colors.blue),
                    onPressed: () {},
                    child: Text(
                      "Forgot password",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue),
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ))
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
