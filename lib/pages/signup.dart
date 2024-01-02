import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final _key = GlobalKey<FormState>();

  void signup() async {
    if (_key.currentState!.validate()) {
      var url = Uri.parse("http://192.168.56.1/online_Shop/register.php");
      final response = await http.post(url, body: {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["status"]);
        //
        // username.clear();
        // email.clear();
        // password.clear();
        // confirmpassword.clear();
      }
      // else{
      //   print("error");
      // }
    }

  }

  @override
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
                  "Sign up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(height: 20),
                Card(
                  child: TextFormField(
                    controller: username,
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
                        labelText: "username",
                        hintText: "username"),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: email,
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
                    controller: password,
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
                        hintText: "Password"),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: confirmpassword,
                    validator: (e) =>
                        e!.isEmpty ? "veillez specifier ce champ" : null,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.phone_locked_outlined,
                            size: 30,
                          ),
                        ),
                        labelText: "confirm password",
                        hintText: "Password"),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue),
                    onPressed: (){
                      signup();
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ElevatedButton(
                //         onPressed: () {
                //           Navigator.push(context,
                //               MaterialPageRoute(builder: (context) => Login()));
                //         },
                //         child: Text(
                //           "Login",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 20),
                //         ))
                //   ],
                // )
              ],
            ),
          ),
        )),
      ),
    );
  }
// Widget build(BuildContext context) {
//   return Scaffold(
//     resizeToAvoidBottomInset: true,
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       elevation: 0,
//       // brightness: Brightness.light,
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: Icon(Icons.arrow_back_ios,
//           size: 20,
//           color: Colors.black,),
//
//
//       ),
//     ),
//     body: SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 40),
//         height: MediaQuery.of(context).size.height - 50,
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Text("Sign up",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//
//                   ),),
//                 SizedBox(height: 20,),
//                 Text("Create an account, It's free ",
//                   style: TextStyle(
//                       fontSize: 15,
//                       color:Colors.grey[700]),)
//
//
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 inputFile(label: "Username"),
//                 inputFile(label: "Email"),
//                 inputFile(label: "Password", obscureText: true),
//                 inputFile(label: "Confirm Password ", obscureText: true),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 3, left: 3),
//               decoration:
//               BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   border: Border(
//                     bottom: BorderSide(color: Colors.black),
//                     top: BorderSide(color: Colors.black),
//                     left: BorderSide(color: Colors.black),
//                     right: BorderSide(color: Colors.black),
//
//
//
//                   )
//
//               ),
//               child: MaterialButton(
//                 minWidth: double.infinity,
//                 height: 60,
//                 onPressed: () {},
//                 color: Color(0xff0095FF),
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//
//                 ),
//                 child: Text(
//                   "Sign up", style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                   color: Colors.white,
//
//                 ),
//                 ),
//
//               ),
//
//
//
//             ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: <Widget>[
//             //     Text("Already have an account?"),
//             //     Text(" Login", style:TextStyle(
//             //         fontWeight: FontWeight.w600,
//             //         fontSize: 18
//             //     ),
//             //     )
//             //   ],
//             // )
//
//
//
//           ],
//
//         ),
//
//
//       ),
//
//     ),
//
//   );
// }
}

// we will be creating a widget for text field
// Widget inputFile({label, obscureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         label,
//         style: TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       TextField(
//         obscureText: obscureText,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                   // color: Colors.grey[400]
//                   ),
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                   // color: Colors.grey[400]
//                   ),
//             )),
//       ),
//       SizedBox(
//         height: 10,
//       )
//     ],
//   );
// }
