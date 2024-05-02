

import 'package:cloud_firestore/cloud_firestore.dart';


class NoteServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _noteCollection =
      _database.collection('notes');

  static Future<void> addNote(String title, String description) async {
    Map<String, dynamic> newNote = {
      'title': title,
      'description': description,
    };
    await _noteCollection.add(newNote);
  }

  static Future<void> updateNote(
      String id, String title, String description) async {
    Map<String, dynamic> updateNote = {
      'title': title,
      'descriiption': description,
    };
    await _noteCollection.doc(id).update(updateNote);
  }
  static Future<void> deleteNote(String id) async {
    await _noteCollection.doc(id).delete();
  }

  static Stream<List<Map<String, dynamic>>> getNoteList() {
    return _noteCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot){
        final data = docSnapshot.data() as Map<String, dynamic>;
        return {'id' : docSnapshot.id, ...data};
      }).toList();
    });
  }
}
