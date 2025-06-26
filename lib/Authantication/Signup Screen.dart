import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Authantication/Forgot%20Password/Otp%20Screen.dart';
import 'package:smailo/Authantication/bloc/signup/bloc_signup.dart';
import 'package:smailo/Authantication/bloc/signup/event_signup.dart';

import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  bool obscurePassword = true;
  bool obscureConformPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "CREATE AN ACCOUNT",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: name,

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.people_outline,
                      size: 25, color: Colors.black26),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                  hintText: "Name",
                  isDense: true,

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phone,

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.people_outline,
                      size: 25, color: Colors.black26),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                  hintText: "Phone Number",
                  isDense: true,

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.email_outlined,
                      size: 25, color: Colors.black26),
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    // Change the color when focused
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: obscurePassword,
                onTap: () {
                  setState(() {
                    obscurePassword != obscurePassword;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.lock_outline, size: 25, color: Colors.black26),
                  hintText: "Password",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      child: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        size: 20,
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    // Change the color when focused
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: conformPassword,
                obscureText: obscureConformPassword,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.people_outline,
                      size: 25, color: Colors.black26),
                  hintText: "Conformation Password",
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureConformPassword = !obscureConformPassword;
                        });
                      },
                      child: Icon(
                        obscureConformPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        size: 20,
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    // Change the color when focused
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                    BlocProvider.of<SignUpBloc>(context).add(
                      FetchSignUpEvent(
                        email: email.text,
                        name: name.text,
                        conformPassword: conformPassword.text,
                        mobile: phone.text,
                        password: password.text,
                      ),
                    );

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OtpPage()));
                },
                child: Container(
                  height: mediaQuery.size.height * 0.065,
                  width: mediaQuery.size.width * 0.83,
                  child: Center(
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black38),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.023,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LogInScreen(
                          phone: email.text,
                          password: password.text,
                        ),
                      ));
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
