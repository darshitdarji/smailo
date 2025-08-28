import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Authantication/bloc/forgot_password/bloc_forgot_password.dart';
import 'package:smailo/Authantication/bloc/forgot_password/event_forgot_password.dart';
import 'Otp Screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
      create: (context) => ForgotPasswordBloc(),
      child: const ForgotPasswordPage(),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back_ios_new, size: 20))),
            const Image(image: AssetImage("assets/img_34.png")),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "FORGOT PASSWORD?",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  hintText: "Phone Number",
                  hintStyle: const TextStyle(color: Colors.black26),
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: Colors.black26,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    // Change the color when focused
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                // BlocProvider.of<ForgotPasswordBloc>(context).add(
                //   FetchForgotPasswordEvent(phone: phoneController.text),
                // );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtpPage(),
                    ));
              },
              child: Container(
                height: mediaQuery.size.height * 0.065,
                width: mediaQuery.size.width * 0.83,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "GET OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
