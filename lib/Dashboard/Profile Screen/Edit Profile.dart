import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_password/bloc_update_password.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_password/event_update_password.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_user_profile/bloc_update_userprofile.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_user_profile/event_update_userprofile.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/bloc_user_profile.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/event_user_profile.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/state_user_profile.dart';
import 'package:flutter/foundation.dart';

class ImageProvider extends ChangeNotifier {
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setSelectedImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditUserProfileBloc>(
          create: (context) => EditUserProfileBloc(),
        ),
        BlocProvider<UpdateUserProfileBloc>(
          create: (context) => UpdateUserProfileBloc(),
        ),
        BlocProvider<UpdatePasswordBloc>(
          create: (context) => UpdatePasswordBloc(),
        ),
      ],
      child: const EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool obscureConformPassword = true;
  bool obscurePassword = true;

  late TextEditingController phone = TextEditingController();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password = TextEditingController();
  late TextEditingController conformPassword = TextEditingController();

  File? image = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<EditUserProfileBloc>(context).add(
      FetchUserProfileEvent(),
    );
  }

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
      print('Failed to pick imageC: $e');
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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
        builder: (context, state) {
          if (state is EditUserProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EditUserProfileLoadedState) {
            final TextEditingController name = TextEditingController(
              text: state.userList.userData.name,
            );
            final TextEditingController phone = TextEditingController(
              text: state.userList.userData.mobileNo,
            );
            final TextEditingController email = TextEditingController(
              text: state.userList.userData.email,
            );

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mediaqury.size.height * 0.013,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
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
                                child: this.image != null
                                    ? Image.file(this.image!, fit: BoxFit.fill)
                                    : Image.network(
                                        state.userList.userData.profileImage,
                                        fit: BoxFit.fill),
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
                                child: const Center(
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
                    const Text(
                      "Basic information",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: mediaqury.size.height * 0.015,
                    ),
                    const Text("Name"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: mediaqury.size.height * 0.05,
                      width: mediaqury.size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10,
                          ),
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
                    const Text("Phone"),
                    SizedBox(
                      height: mediaqury.size.height * 0.013,
                    ),
                    SizedBox(
                      height: mediaqury.size.height * 0.05,
                      // width: mediaqury.size.width * 1,
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10,
                          ),
                          alignLabelWithHint: true,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black12,
                          ),
                          hintText: "   Phone",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaqury.size.height * 0.013,
                    ),
                    const Text("Email"),
                    SizedBox(
                      height: mediaqury.size.height * 0.013,
                    ),
                    Container(
                      height: mediaqury.size.height * 0.05,
//                      width: mediaqury.size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
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
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<UpdateUserProfileBloc>(context).add(
                            FetchUpdateUserProfileEvent(
                              mobileNo: phone.text,
                              email: email.text,
                              name: name.text,
                              image: state.userList.userData.profileImage,
                            ),
                          );
                          BlocProvider.of<EditUserProfileBloc>(context)
                              .add(FetchUserProfileEvent());
                        },
                        child: Container(
                          height: mediaqury.size.height * 0.045,
                          width: mediaqury.size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
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
                    ),
                    SizedBox(
                      height: mediaqury.size.height * 0.023,
                    ),
                    const Center(
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
                    const Text(
                      "Enter New Password",
                      style: TextStyle(
                        color: Colors.black,
                      ),
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
                        controller: password,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  obscurePassword = !obscurePassword;
                                },
                              );
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              size: 20,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10,
                          ),
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                          hintText: "  .......",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaqury.size.height * 0.013,
                    ),
                    const Text(
                      "Re-Enter New Password",
                      style: TextStyle(
                        color: Colors.black,
                      ),
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
                        controller: conformPassword,
                        obscureText: obscureConformPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  obscureConformPassword =
                                      !obscureConformPassword;
                                },
                              );
                            },
                            child: Icon(
                              obscureConformPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              size: 20,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10,
                          ),
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                          hintText: "   ........",
                          hintStyle: const TextStyle(
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
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<UpdatePasswordBloc>(context).add(
                            FetchUpdatePasswordEvent(
                                conformPassword: conformPassword.text,
                                password: password.text),
                          );
                          BlocProvider.of<EditUserProfileBloc>(context)
                              .add(FetchUserProfileEvent());
                        },
                        child: Container(
                          height: mediaqury.size.height * 0.045,
                          width: mediaqury.size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: const Center(
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
                    ),
                  ],
                ),
              ),
            );
          } else if (state is EditUserProfileErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}
