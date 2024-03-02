// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/model/note_model.dart';
import 'package:secure_private_notes/services/auth/firebase_auth_service.dart';
import 'package:secure_private_notes/services/firestore/firestore_notes_service.dart';
import 'package:secure_private_notes/services/internet_checker.dart';
import 'package:secure_private_notes/strings/app_strings.dart';

import '../../../utils/encrypt_decrypt_utils.dart';
import '../notes/note_cubit.dart';
part 'backup_state.dart';

class BackupCubit extends Cubit<BackupState> {
  BackupCubit() : super(BackupInitial());

  final FirestoreNotesService _firestoreNotesService = FirestoreNotesService();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final InternetChecker internetChecker = InternetChecker();
  Future<void> deleteBackups() async {
    if (await internetChecker.hasConnection) {
      FirebaseUser? user = await _firebaseAuthService.getCurrentUser();
      if (user != null) {
        emit(DeletingBackup());
        try {
          await _firestoreNotesService.deleteFromDatabase(user.uid);
          emit(DeleteBackupSuccess());
        } catch (e) {
          emit(DeleteBackupFailure(e.toString()));
        }
      } else {
        emit(UserLoggedOut());
      }
    } else {
      emit(OfflineFailure());
    }
  }

  Future<void> restoreNotes() async {
    if (await internetChecker.hasConnection) {
      FirebaseUser? user = await _firebaseAuthService.getCurrentUser();
      if (user != null) {
        try {
          emit(RestoreBackupLoading());

          List<dynamic>? notesData =
              await _firestoreNotesService.restoreFromDatabase(user.uid);
          if (notesData == null) {
            emit(RestoreBackupFailure(noBackupFoundedMessage));
          } else {
            List<NoteModel> notesList = notesData.map((note) {
              return NoteModel(
                  title: Crypto.decryptText(note["title"], user.email),
                  subTitle: Crypto.decryptText(note["subTitle"], user.email),
                  date: note["date"],
                  isFavorite: note["isFavorite"]);
            }).toList();

            NoteCubit noteCubit = NoteCubit();

            for (var note in notesList) {
              await noteCubit.addNote(note);
            }
            emit(RestoreBackupDoneSuccessfully());
          }
        } on PlatformException catch (e) {
          emit(RestoreBackupFailure(e.message!));
        }
      } else {
        emit(UserLoggedOut());
      }
    } else {
      emit(OfflineFailure());
    }
  }

  Future<void> uploadNotes(List<NoteModel> notes) async {
    if (await internetChecker.hasConnection) {
      if (notes.isEmpty) {
        emit(NoNotesToBackup());
      } else {
        FirebaseUser? user = await _firebaseAuthService.getCurrentUser();

        if (user != null) {
          emit(BackupCreating());
          final List<Map<String, dynamic>> notesData = notes.map((note) {
            return {
              'title': Crypto.encryptText(note.title, user.email),
              'subTitle': Crypto.encryptText(note.subTitle, user.email),
              'date': note.date,
              "isFavorite": note.isFavorite
            };
          }).toList();

          try {
            await _firestoreNotesService.uploadToDatabase(notesData, user.uid);
            emit(BackupCreatedSuccessfully());
          } on PlatformException catch (e) {
            emit(BackupCreatingFailure(e.message!));
          }
        } else {
          emit(UserLoggedOut());
        }
      }
    } else {
      emit(OfflineFailure());
    }
  }
}
