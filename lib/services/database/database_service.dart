import 'package:hive/hive.dart';
import 'package:secure_private_notes/strings/app_strings.dart';

import '../../model/note_model.dart';

class DatabaseService {
  final notesBox = Hive.box<NoteModel>(boxName);
  bool isDuplicate(NoteModel note) {
    return notesBox.values
        .any((storedNote) => storedNote.subTitle == note.subTitle);
  }

  addNote(NoteModel note) {
    if (!isDuplicate(note)) {
      notesBox.add(note);
    }
  }

  updateNote(var key, NoteModel note) {
    notesBox.delete(key);
    addNote(note);
  }

  deleteNote(NoteModel note) {
    note.delete();
  }

  toggleFavorites(NoteModel note) {
    final updatedNote = note..isFavorite = !note.isFavorite;
    notesBox.put(note.key, updatedNote);
  }

  List<NoteModel> getNotes() {
    return notesBox.values.toList().toSet().toList();
  }
}
