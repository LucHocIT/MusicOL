import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDocDataSource {
  UsersDocDataSource(this._firestore);
  
  final FirebaseFirestore _firestore;
  
  CollectionReference<Map<String, dynamic>> get _users => 
      _firestore.collection('users');
  
  /// Get user document by uid
  Future<Map<String, dynamic>?> getUserDoc(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;
    return doc.data();
  }
  
  /// Create or update user document
  Future<void> setUserDoc(String uid, Map<String, dynamic> data) async {
    await _users.doc(uid).set(data, SetOptions(merge: true));
  }
  
  /// Stream user document changes
  Stream<Map<String, dynamic>?> watchUserDoc(String uid) {
    return _users.doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return doc.data();
    });
  }
}