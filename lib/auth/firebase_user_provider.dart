import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DenemeFirebaseUser {
  DenemeFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

DenemeFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DenemeFirebaseUser> denemeFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<DenemeFirebaseUser>((user) => currentUser = DenemeFirebaseUser(user));
