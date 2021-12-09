import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HolmesFirebaseUser {
  HolmesFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

HolmesFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HolmesFirebaseUser> holmesFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<HolmesFirebaseUser>((user) => currentUser = HolmesFirebaseUser(user));
