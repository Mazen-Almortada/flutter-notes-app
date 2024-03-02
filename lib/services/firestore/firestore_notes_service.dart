// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_private_notes/strings/app_strings.dart';

class FirestoreNotesService {
  final CollectionReference _firestore =
      Firestore.instance.collection(notesCollectionName);

  Future<bool> doseDocumentIsExist(String documentId) async {
    final DocumentSnapshot documentSnapshot =
        await _firestore.document(documentId).get();

    return documentSnapshot.exists;
  }

  deleteFromDatabase(String userId) async {
    await _firestore.document(userId).delete();
  }

  uploadToDatabase(List<Map<String, dynamic>> notesData, String userId) async {
    final bool isExist = await doseDocumentIsExist(userId);
    if (isExist) {
      await _firestore
          .document(userId)
          .updateData({'notes': FieldValue.arrayUnion(notesData)});
    } else {
      await _firestore.document(userId).setData({
        'notes': notesData,
      });
    }
  }

  restoreFromDatabase(String userId) async {
    final DocumentSnapshot snapshot = await _firestore.document(userId).get();
    final isExist = await doseDocumentIsExist(userId);
    if (!isExist) {
      return null;
    }
    return snapshot.data["notes"] as List<dynamic>;
  }
}
