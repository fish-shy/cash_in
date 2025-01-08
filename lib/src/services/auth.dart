import 'package:cash_in/models/user.dart';
import 'package:cash_in/src/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //buat user obj berdasarkan userid firbase
  MyUser? _userFromCredUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromCredUser(user));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromCredUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in to
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromCredUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithPhoneNumberAndPassword(
      String phoneNumber, String password) async {
    try {
      // Step 1: Search for the document in Firestore with the given phone number
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cash-in')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No user found with this phone number.');
        return null;
      }

      // Step 2: Get the UID (document name)
      String uid = querySnapshot.docs.first.id;

      // Step 3: Fetch the user from Firebase Authentication by UID
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null || user.uid != uid) {
        print('Authentication failed: UID mismatch.');
        return null;
      }

      String? email = user.email;
      if (email == null) {
        print('Email not found for this user.');
        return null;
      }

      // Step 4: Authenticate with the retrieved email and password
      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } catch (e) {
      print('Error during authentication: ${e.toString()}');
      return null;
    }
  }

//register with Email dan Password
  Future registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String phoneNumber,
      required String name}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //crate doc for the user
      await DatabaseService(uid: user!.uid).updateUserData(
        name: name,
        phoneNumber: phoneNumber,
      );

      return _userFromCredUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign aot
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

Future registerUserPin({required String pin, required String uid}) async {
  try {
    await DatabaseService(uid: uid).updateUserPin(pin: pin);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<bool> signInPin({
  required String uid,
  required String enteredPin, // Pass the PIN entered by the user
}) async {
  try {
    // Step 1: Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Step 2: Check if the user is authenticated and UID matches
    if (user == null || user.uid != uid) {
      print('Authentication failed: UID mismatch or user not logged in.');
      return false;
    }

    // Step 3: Retrieve user data from Firestore
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
        .collection('cash-in')
        .doc(uid)
        .get();

    if (!userDoc.exists) {
      print('User data not found.');
      return false;
    }

    // Step 4: Extract stored PIN
    Map<String, dynamic> userData = userDoc.data()!;
    String storedPin = userData['pin'] ?? '';

    // Step 5: Validate the entered PIN
    if (enteredPin == storedPin) {
      print('Authentication successful.');
      return true;
    } else {
      print('Authentication failed: Incorrect PIN.');
      return false;
    }
  } catch (e) {
    print('Error during authentication: ${e.toString()}');
    return false;
  }
}
