import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smailo/Authantication/Forgot%20Password/Forgot%20Password.dart';
import 'package:smailo/Authantication/Signup%20Screen.dart';
import 'package:smailo/Authantication/bloc/log_in/bloc_login.dart';
import 'package:smailo/Authantication/bloc/log_in/event_login.dart';

class LogInScreen extends StatefulWidget {
  final String phone;
  final String password;

  const LogInScreen({super.key, required this.phone, required this.password});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogInBloc>(
      create: (context) => LogInBloc(),
      child: LoginPage(
        phone: widget.phone,
        password: widget.password,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String phone;
  final String password;

  const LoginPage({super.key, required this.phone, required this.password});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = false;
  bool cart = false;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool obscurePassword = true;
  bool obscurePhone = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.06,
                ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.3,
                    width: mediaQuery.size.width,
                    child: Image(
                        image: AssetImage("assets/img_31.png"),
                        fit: BoxFit.cover),
                  ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "LOG IN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 40,
                ),
                Focus(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      focusNode: emailFocusNode,
                      onTap: () {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      },
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.phone, size: 25, color: Colors.black26),
                        hintText: "Phone number",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Colors.blue), // Change the color when focused
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    obscureText: obscurePassword,
                    controller: password,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline,
                          size: 25, color: Colors.black26),
                      hintText: "Password",
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
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Colors.blue), // Change the color when focused
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ));
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(

                  onTap: () {
                    setState(() {
                      // if(widget.password.toString() == password.text && widget.phone.toString() == phone.text){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));

                    });

                    BlocProvider.of<LogInBloc>(context).add(
                      FetchLogInEvent(
                        mobile: phone.text,
                        password: password.text,
                      ),
                    );
                    // setState(() {
                    //   if (phone.text.isNotEmpty && password.text.isNotEmpty) {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => Otpscreen(),
                    //         ),
                    //         (route) => false);
                    //   } else {
                    //     Fluttertoast.showToast(
                    //       msg: "Please enter both email and password  ",
                    //       // gravity: ToastGravity.BOTTOM,
                    //       fontSize: 15,
                    //       backgroundColor: Colors.black26,
                    //       textColor: Colors.white,
                    //       toastLength: Toast.LENGTH_LONG,
                    //     );
                    //   }
                    // });
                  },
                  child: Container(
                    height: mediaQuery.size.height * 0.06,
                    width: mediaQuery.size.width * 0.83,
                    child: Center(
                        child: Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            // if(widget.password == password && widget.phone == phone){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                            // }else{
                            //    const Center(
                            //     child: Text("No Data"),
                            //   );
                          }
                              // }
                              );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
