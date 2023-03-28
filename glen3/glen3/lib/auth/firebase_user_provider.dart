import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Glen3FirebaseUser {
  Glen3FirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

Glen3FirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Glen3FirebaseUser> glen3FirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Glen3FirebaseUser>(
      (user) {
        currentUser = Glen3FirebaseUser(user);
        return currentUser!;
      },
    );
