import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:propertypall/constant/constant.dart';

import '../widgets/login_signup_btn.dart';
import '../widgets/textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent!'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       
        title: Text('Forgot Password'),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            //logo header pic
            Container(
                  height: MediaQuery.of(context).size.height*0.33,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/splash.jpg"),
                  ),
                  ),
                   
                ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextField(
                    controller: _emailController, icon: Icon(Icons.email), hintText: 'Enter Your Email',

                  ),
                  SizedBox(height: 40),
                  MyButton(
                    onPressed: _resetPassword,
                    text: 'Send Reset Email'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
