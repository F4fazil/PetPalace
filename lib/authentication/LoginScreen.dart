import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constant/constant.dart';
import '../screens/feature_screens/homeScreen.dart';
import '../widgets/Osm_dailoge.dart';
import '../widgets/login_signup_btn.dart';
import '../widgets/textfield.dart';
import 'Forget_Password.dart';
import 'SignupPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  // Sign In Function
  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseException catch (e) {
      OsmDailogue(context).showSnackBar(e.code);
    }
    
   Future.delayed( const Duration(milliseconds:500), () {
  OsmDailogue(context).showSnackBar("Logged In");
});

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0Xffb4eeb4),
          ),
          child: Column(
            children: [
              // Logo Header Image
              Container(
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/splash.jpg"),
                  ),
                ),
              ),
              // Form Section
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0Xff66cdaa),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 50),
                            child: MyTextField(
                              controller: email,
                              icon: Icon(Icons.mail_sharp, color: btnColor),
                              hintText: 'Enter your Email',
                            ),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: MyTextField(
                              obscureText: true,
                              controller: password,
                              icon: Icon(Icons.password, color: btnColor),
                              hintText: 'Password',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 180),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                  color: Color(0Xff66cdaa),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Button and Text at the Bottom
                      Positioned(
                        bottom: 40, // Position 40px from the bottom
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            // Login Button
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: MyButton(
                                onPressed: () async {
                                  await signIn();
                                },
                                text: 'Login',
                              ),
                            ),
                            const SizedBox(height: 20),
                            // "Does not have an account?" Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Does not have an account?',
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
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
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
