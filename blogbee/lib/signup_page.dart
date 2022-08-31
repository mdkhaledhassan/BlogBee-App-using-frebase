import 'package:blogbee/helper.dart';
import 'package:blogbee/signin_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              obscureText: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  var e = emailcontroller.text;
                  var p = passwordcontroller.text;

                  var obj = Helper().signUp(e, p, context);
                },
                child: Text("Sign Up")),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => SignInPage())));
                },
                child: Text("Already account? Login Here"))
          ],
        ),
      ),
    );
  }
}
