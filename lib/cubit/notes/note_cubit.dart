import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/model/note_model.dart';
import 'package:secure_private_notes/services/database/database_service.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  List<NoteModel>? notes;
  DatabaseService databaseService = DatabaseService();

  addNote(NoteModel note) async {
    emit(AddNoteLoading());
    try {
      await databaseService.addNote(note);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(e.toString()));
    }
  }

  fetchNotes() {
    notes = databaseService.getNotes();
    emit(NoteSuccess());
  }

  updateNote(var key, NoteModel note) async {
    try {
      await databaseService.updateNote(key, note);

      emit(UpdateNoteSuccess());
    } catch (e) {
      emit(UpdateNoteFailure(e.toString()));
    }
  }

  deleteNote(NoteModel note) async {
    try {
      await databaseService.deleteNote(note);
      notes = databaseService.getNotes();
      emit(DeleteNoteSuccess());
    } catch (e) {
      emit(DeleteNoteFailure(e.toString()));
    }
  }

  toggleFavorites(NoteModel note) async {
    await databaseService.toggleFavorites(note);

    notes = databaseService.getNotes();
    emit(AddedToFavorite());
  }
}
