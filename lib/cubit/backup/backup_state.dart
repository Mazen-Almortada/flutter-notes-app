part of 'backup_cubit.dart';

abstract class BackupState {}

class BackupInitial extends BackupState {}

class UserLoggedOut extends BackupState {
  final String message = loginRequiredMessage;
}

class NoNotesToBackup extends BackupState {
  final String message = noNotesMessage;
}

class BackupCreating extends BackupState {}

class BackupCreatingFailure extends BackupState {
  final String errorMessage;

  BackupCreatingFailure(this.errorMessage);
}

class BackupCreatedSuccessfully extends BackupState {}

class RestoreBackupLoading extends BackupState {}

class RestoreBackupFailure extends BackupState {
  final String errorMessage;

  RestoreBackupFailure(this.errorMessage);
}

class RestoreBackupDoneSuccessfully extends BackupState {}

class DeletingBackup extends BackupState {}

class DeleteBackupFailure extends BackupState {
  final String errorMessage;

  DeleteBackupFailure(this.errorMessage);
}

class DeleteBackupSuccess extends BackupState {}

class OfflineFailure extends BackupState {
  final String errorMessage = connectionFailure;
}
