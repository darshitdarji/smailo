import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Authantication/Forgot%20Password/Otp%20Screen.dart';

import 'LoginScreen.dart';

// import 'fLoginScreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {

  TextEditingController name = TextEditingController();
      TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformpassword = TextEditingController();


  bool obscurepassword = true;
  bool obscureconformpassword = true;

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text("CREATE AN ACCOUNT",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 25)),
                SizedBox(height: 60,),

                TextFormField(
                  controller:  name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.people_outline, size: 25, color: Colors.black26),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignLabelWithHint: true,
                    hintText: "Name",
                    enabledBorder: OutlineInputBorder(

                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Change the color when focused
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_outlined, size: 25, color: Colors.black26),
                    hintText: "Phone number",
                    contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Change the color when focused
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email_outlined, size: 25, color: Colors.black26),
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Change the color when focused
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: password,
                  obscureText: obscurepassword,
                  onTap: (){
                    setState(() {
                      obscurepassword != obscurepassword;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, size: 25, color: Colors.black26),
                    hintText: "Password",
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignLabelWithHint: true,
                    suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            obscurepassword =! obscurepassword;
                          });
                        },
                        child: Icon(obscurepassword?Icons.visibility_off_outlined:Icons.visibility,size: 20,)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Change the color when focused
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller:  conformpassword,
                  obscureText: obscureconformpassword,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.people_outline, size: 25, color: Colors.black26),
                    hintText: "Conformation Password",

                    suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            obscureconformpassword =! obscureconformpassword;
                          });
                        },
                        child: Icon(obscureconformpassword?
                        Icons.visibility_off_outlined:Icons.visibility,size: 20,)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Change the color when focused
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 40,),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Otpscreen()));
                  },
                  child: Container(
                    height: mediaquery.size.height*0.065,
                    width: mediaquery.size.width*0.83,
                    child: Center(child: Text("REGISTER",style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),)),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                    Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Already have an account?",style: TextStyle(color: Colors.black38),),
            SizedBox(width: mediaquery.size.width*0.023,),
            InkWell(
                    onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => Loginscreen(),));
                    },

                    child: Text("Log In",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))

                    ],),




              ],
            ),
          ),
        ),
      ),

    );
  }
}
