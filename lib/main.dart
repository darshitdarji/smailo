import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Dashboard.dart';
import 'notification/firebase_options.dart';
import 'notification/firebse.dart';


Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("SOME NOTIFICATION RECEIVE================");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotification();
  FirebaseApi.intt();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: Dashboard(),
    );
  }
}
