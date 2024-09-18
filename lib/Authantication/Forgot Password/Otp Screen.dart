import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Authantication/bloc/resend_otp/bloc_resend_otp.dart';
import 'package:smailo/Authantication/bloc/resend_otp/event_resend_otp.dart';
import 'package:smailo/Dashboard/Dashboard.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ResendOtpBloc>(
//       create: (context) => ResendOtpBloc(),
//       child: OtpPage(),
//     );
//   }
// }

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  late int _timeoutSeconds;
  late Timer _timer;
  bool _showResendText = false;
  String? mToken= '';

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(4, (index) => TextEditingController());
    _timeoutSeconds = 20; // Set your timeout duration in seconds
    _startTimeout();
    // getToken();
    // requestPermission();
    //
    // // FirebaseMessaging.instance.getAPNSToken().then((NewToken){
    // //   print("newtoken");
    // //   print(NewToken);
    // //  }
  }

  // void requestPermission() async {
  //   FirebaseMessaging messenging = FirebaseMessaging.instance;
  //   NotificationSettings setting = await messenging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     carPlay: false,
  //     badge: true,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (setting.authorizationStatus == AuthorizationStatus.authorized) {
  //     print("User Gramnt Permission");
  //   } else if (setting.authorizationStatus == AuthorizationStatus.provisional) {
  //     print("User Grant Permission Provisional");
  //   } else {
  //     print("permission Denided");
  //   }
  // }
  //
  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       mToken = token;
  //       print("My Token is $mToken");
  //     });
  //   });
  // }
  //







  void _restartTimeout() {
    setState(() {
      _showResendText = false;
      _timeoutSeconds = 20; // Reset the timeout duration
    });
    _startTimeout();
  }

  void _startTimeout() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (_timeoutSeconds == 0) {
        timer.cancel();
        setState(() {
          _showResendText = true;
        });

        // Handle timeout actions here
        _clearTextFields(); // Clear text fields when timeout
      } else {
        setState(() {
          _timeoutSeconds--;
        });
      }
    });
  }

  void _clearTextFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    // Other dispose actions...

    super.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length == 1) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        // If the last digit is entered, you can trigger verification here
      }
    }
  }

  int chengecolor = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image(image: AssetImage("assets/img_28.png")),
            Text(
              "OTP VERIFICATION",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter Your Verificatio Code..",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black26),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  height: 50,
                  width: 50,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onSaved: (value) {},
                    onChanged: (value) => _onChanged(index, value),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                );
              }),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Timeout in $_timeoutSeconds   ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.03,
            ),
            _showResendText
                ? Column(
                    children: [
                      Text(
                        "Didn't You Received any Code?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          // await FirebaseAuth.instance.verifyPhoneNumber(
                          //   phoneNumber: '+44 7123 123 456',
                          //   verificationCompleted: (PhoneAuthCredential credential) {},
                          //   verificationFailed: (FirebaseAuthException e) {},
                          //   codeSent: (String verificationId, int? resendToken) {},
                          //   codeAutoRetrievalTimeout: (String verificationId) {},
                          // );
                          // setState(() {
                          //   BlocProvider.of<ResendOtpBloc>(context).add(FetchResendOtpEvent());
                          //
                          // });
                          _restartTimeout();
                        },
                        child: Text(
                          "Resend New Code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ),
                    (route) => false);
              },
              child: Container(
                height: mediaQuery.size.height * 0.065,
                width: mediaQuery.size.width * 0.83,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    "Verify",
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
