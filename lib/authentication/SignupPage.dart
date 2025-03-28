import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant/constant.dart';
import '../widgets/Osm_dailoge.dart';
import '../widgets/login_signup_btn.dart';
import '../widgets/textfield.dart';
import 'LoginScreen.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void _saveTokenToDatabase(String? token) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      final userRef = FirebaseFirestore.instance
          .collection('usertokens')
          .doc(user.uid);
      userRef.set({'token': token}, SetOptions(merge: true));
    }
  }

  Future<void> signUp() async {
    if (passwordTextController.text != confirmPasswordTextController.text) {
      OsmDailogue(context).showSnackBar("Password does not match");
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailTextController.text,
            password: passwordTextController.text,
          );
      await makeUserDocument(userCredential);
      Future.delayed(const Duration(milliseconds: 500), () {
        OsmDailogue(context).showSnackBar("User Registered");
      });
      String? token = await FirebaseMessaging.instance.getToken();
      _saveTokenToDatabase(token);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseException catch (e) {
      OsmDailogue(context).showSnackBar(e.code);
    }
  }

  Future<void> makeUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
            "name": nameTextController.text,
            "userEmail": userCredential.user!.email,
            "password": passwordTextController.text,
            "uid": userCredential.user!.uid,
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Column(
            children: [
              // Header Image
              Container(
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(10),
                  ),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/splash.jpg"),
                  ),
                ),
              ),
              // Form Section
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Stack(
                    children: [
                      // Form Fields
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "Signup",
                            style: TextStyle(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 20,
                            ),
                            child: MyTextField(
                              controller: nameTextController,
                              icon: Icon(Icons.person, color: btnColor),
                              hintText: 'Name',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 20,
                            ),
                            child: MyTextField(
                              controller: emailTextController,
                              icon: Icon(Icons.mail_sharp, color: btnColor),
                              hintText: 'Email',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 20,
                            ),
                            child: MyTextField(
                              obscureText: true,
                              controller: passwordTextController,
                              icon: Icon(Icons.mail_sharp, color: btnColor),
                              hintText: 'Password',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 20,
                            ),
                            child: MyTextField(
                              obscureText: true,
                              controller: confirmPasswordTextController,
                              icon: Icon(Icons.password, color: btnColor),
                              hintText: 'Confirm Password',
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                      // Button and Text at the Bottom
                      Positioned(
                        bottom: 40, // 40px from the bottom
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            // Signup Button
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: MyButton(
                                onPressed: () async {
                                  await signUp();
                                },
                                text: 'Signup',
                              ),
                            ),
                            const SizedBox(height: 20),
                            // "Already have an account?" Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.teal.shade300,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
