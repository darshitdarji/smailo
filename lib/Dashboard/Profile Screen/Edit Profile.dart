import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Profile%20screen.dart';

class Editprofile extends StatefulWidget {
  Editprofile({
    super.key,
  });

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  bool obscureconformpassword = true;
  bool obscurepassword = true;

  File? image = null;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaqury = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue, Colors.blue.shade900],
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Center(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Editprofile(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 60,
                        child: Container(
                          height: mediaqury.size.height * 0.15,
                          width: mediaqury.size.height * 0.15,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipOval(
                            child: image != null
                                ? Image.file(image!, fit: BoxFit.fill)
                                : Placeholder(), // You can use Placeholder() or any other widget as a placeholder
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 90,
                        top: 85,
                      ),
                      child: InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          height: mediaqury.size.height * 0.03,
                          width: mediaqury.size.height * 0.03,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Basic information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.015,
              ),
              Text("Name"),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    hintText: "   name",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Text("Phone"),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Container(
                height: mediaqury.size.height * 0.05,
                width: mediaqury.size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10,
                    ),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    hintText: "   Phone",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Text("Email"),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Container(
                height: mediaqury.size.height * 0.05,
                width: mediaqury.size.width * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    hintText: "   enter your mail",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.025,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: mediaqury.size.height * 0.045,
                  width: mediaqury.size.width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.023,
              ),
              Center(
                child: Text(
                  "Password Change",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Text(
                "Enter New Password",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Container(
                height: mediaqury.size.height * 0.05,
                width: mediaqury.size.width * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  obscureText: obscurepassword,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            obscurepassword = !obscurepassword;
                          },
                        );
                      },
                      child: Icon(
                        obscurepassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        size: 20,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10,
                    ),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    hintText: "  .......",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Text(
                "Re-Enter New Password",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.013,
              ),
              Container(
                height: mediaqury.size.height * 0.05,
                width: mediaqury.size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  obscureText: obscureconformpassword,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              obscureconformpassword = !obscureconformpassword;
                            },
                          );
                        },
                        child: Icon(
                          obscureconformpassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          size: 20,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                      hintText: "   ........",
                      hintStyle: TextStyle(color: Colors.black12)),
                ),
              ),
              SizedBox(
                height: mediaqury.size.height * 0.025,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: mediaqury.size.height * 0.045,
                  width: mediaqury.size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Update Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
