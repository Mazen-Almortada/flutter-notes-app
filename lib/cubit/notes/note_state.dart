part of 'note_cubit.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteSuccess extends NoteState {}

class UpdateNoteSuccess extends NoteState {}

class AddNoteLoading extends NoteState {}

class AddNoteSuccess extends NoteState {}

class AddNoteFailure extends NoteState {
  final String eMessage;
  AddNoteFailure(this.eMessage);
}

class DeleteNoteSuccess extends NoteState {}

class AddedToFavorite extends NoteState {}

class DeleteNoteFailure extends NoteState {
  final String eMessage;
  DeleteNoteFailure(this.eMessage);
}

class UpdateNoteFailure extends NoteState {
  final String eMessage;
  UpdateNoteFailure(this.eMessage);
}
