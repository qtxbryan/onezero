import 'package:onezero/controller/database.dart';
import 'package:onezero/controller/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onezero/models/User.dart';

class UserController {
  Database db = Database();

  User? user = Auth().currentUser;

  Stream<DocumentSnapshot> getUserDocStream() {
    return db.readSingleDocument('users', user!.uid);
  }
}
