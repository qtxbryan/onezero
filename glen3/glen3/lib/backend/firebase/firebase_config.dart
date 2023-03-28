import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDFW1_LVQd6GmmnZ8UxsHROIG-hQKT-NDE",
            authDomain: "glendon-30d54.firebaseapp.com",
            projectId: "glendon-30d54",
            storageBucket: "glendon-30d54.appspot.com",
            messagingSenderId: "694641340861",
            appId: "1:694641340861:web:98f6d37d18b637eaf762d4"));
  } else {
    await Firebase.initializeApp();
  }
}
