import 'package:cash_in/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('cash-in');

  // Update user data (name and phone number)
  Future updateUserData({required String phoneNumber, required String name}) async {
    try{
    return await userCollection.doc(uid).set({
      'name': name,
      'phoneNumber': phoneNumber,
    }, SetOptions(merge: true));
    }catch(e)
    {
      print("failed to register $e");
    }
     // Ensures fields are merged instead of overwriting the document
  }

  // Update user PIN
  Future updateUserPin({required String pin}) async {
  try {
    await userCollection.doc(uid).set({
      'pin': pin,
    }, SetOptions(merge: true));
    print("PIN updated successfully.");
  } catch (e) {
    print("Failed to update PIN: $e");
  }
}

  // Stream of brews
  Stream<QuerySnapshot> get brews {
    return userCollection.snapshots();
  }

  // Map user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>; 
    return UserData(
      uid: uid,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      pin: data['pin'] ?? '',

    );
  }

  // Get user document stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map((snapshot) {
      return _userDataFromSnapshot(snapshot);
    });
  }
}
