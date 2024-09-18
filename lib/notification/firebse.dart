import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handlebackgroundmessenging(RemoteMessage message) async {
  print("title:${message.notification?.title}");
  print("body:${message.notification?.body}");
  print("playload:${message.data}");
}
class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future intt() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      announcement: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
    final token = await _firebaseMessaging.getToken();
    print("TOKEN===================$token");
  }
}
