import 'package:blogbee/helper.dart';
import 'package:blogbee/signup_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Sign In"),
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
                obscureText: true),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  var e = emailcontroller.text;
                  var p = passwordcontroller.text;

                  var obj = Helper().signIn(e, p, context);
                },
                child: Text("Sign In")),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => SignUpPage())));
                },
                child: Text("Don't have an account? SignUp Here"))
          ],
        ),
      ),
    );
  }
}
