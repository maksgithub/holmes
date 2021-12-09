import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Holmes3FirebaseUser {
  Holmes3FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Holmes3FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Holmes3FirebaseUser> holmes3FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Holmes3FirebaseUser>(
        (user) => currentUser = Holmes3FirebaseUser(user));
