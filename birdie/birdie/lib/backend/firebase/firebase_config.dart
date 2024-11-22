import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDlqCz3mb0MM8CfUoJgBAsubzws4Bl95vc",
            authDomain: "birdie-31581.firebaseapp.com",
            projectId: "birdie-31581",
            storageBucket: "birdie-31581.firebasestorage.app",
            messagingSenderId: "83100758331",
            appId: "1:83100758331:web:9778f4551d504ed75e471e",
            measurementId: "G-FGMK9NH2XM"));
  } else {
    await Firebase.initializeApp();
  }
}
