import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCXgUnam-08FGjtBUtqsl0m7VfcwzICiBU",
            authDomain: "test-7c593.firebaseapp.com",
            projectId: "test-7c593",
            storageBucket: "test-7c593.appspot.com",
            messagingSenderId: "434781259509",
            appId: "1:434781259509:web:274533d1e7c89400c067bc",
            measurementId: "G-BYC82S3N55"));
  } else {
    await Firebase.initializeApp();
  }
}
