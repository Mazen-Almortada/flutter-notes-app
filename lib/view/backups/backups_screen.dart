import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/utils/alert_dialog.dart';
import 'package:secure_private_notes/utils/snack_bar.dart';
import 'package:secure_private_notes/widgets/listtile_items_card.dart';
import '../../cubit/backup/backup_cubit.dart';
import '../../cubit/notes/note_cubit.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text_widget.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = BackupCubit();
    return Scaffold(
      appBar: CustomAppBar(
        onTapLeading: () {
          Routes.back(context);
        },
        leadingIcon: Icons.arrow_back_ios,
        title: const TitlesText(
          text: "Backup & Restore",
          size: 20,
        ),
      ),
      body: BlocListener<BackupCubit, BackupState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is UserLoggedOut) {
              SnackBarUtils.show(context, state.message, SnackBarType.failure);
            } else if (state is NoNotesToBackup) {
              SnackBarUtils.show(context, state.message, SnackBarType.failure);
            } else if (state is BackupCreating) {
              DialogUtils.showLadingDialog(context);
            } else if (state is BackupCreatingFailure) {
              Routes.back(context);
              SnackBarUtils.show(
                  context, state.errorMessage, SnackBarType.failure);
            } else if (state is BackupCreatedSuccessfully) {
              Routes.back(context);
              SnackBarUtils.show(context, "Backup created successfully!",
                  SnackBarType.success);
            } else if (state is RestoreBackupLoading) {
              DialogUtils.showLadingDialog(context);
            } else if (state is RestoreBackupFailure) {
              Routes.back(context);
              SnackBarUtils.show(
                  context, state.errorMessage, SnackBarType.failure);
            } else if (state is RestoreBackupDoneSuccessfully) {
              Routes.back(context);
              context.read<NoteCubit>().fetchNotes();
              SnackBarUtils.show(context, "Backup restored successfully!",
                  SnackBarType.success);
            } else if (state is DeletingBackup) {
              DialogUtils.showLadingDialog(context);
            } else if (state is DeleteBackupFailure) {
              Routes.back(context);
              SnackBarUtils.show(
                  context, state.errorMessage, SnackBarType.failure);
            } else if (state is DeleteBackupSuccess) {
              Routes.back(context);
              SnackBarUtils.show(context, "Backups deleted successfully",
                  SnackBarType.success);
            } else if (state is OfflineFailure) {
              SnackBarUtils.show(
                  context, state.errorMessage, SnackBarType.failure);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: ListView(
              children: [
                Center(
                  child: SizedBox(
                      child: Image.asset(
                    "images/backup.png",
                    height: 200,
                  )),
                ),
                ItemsCard(
                    child: ListTile(
                  onTap: () async {
                    final notes = BlocProvider.of<NoteCubit>(context).notes;
                    bloc.uploadNotes(notes!);
                  },
                  title: TitlesText(
                    text: "Create Backup",
                    size: 15,
                    color: AppStyle.primaryColor,
                  ),
                  subtitle: TitlesText(
                    text: "Create Backup for Notes to Cloud Storage",
                    size: 10,
                    color: AppStyle.subTitleColor,
                  ),
                )),
                ItemsCard(
                    child: ListTile(
                  onTap: () async {
                    bloc.restoreNotes();
                  },
                  title: TitlesText(
                    text: "Restore",
                    size: 15,
                    color: AppStyle.primaryColor,
                  ),
                  subtitle: TitlesText(
                    text: "Restore Notes Backup",
                    size: 10,
                    color: AppStyle.subTitleColor,
                  ),
                )),
                ItemsCard(
                  child: ListTile(
                      onTap: () {
                        DialogUtils.show(
                          context,
                          content:
                              "Notes backup will be deleted , Are you sure ?",
                          action: "Delete",
                          onPressed: () {
                            bloc.deleteBackups();
                            Routes.back(context);
                          },
                        );
                      },
                      title: TitlesText(
                          text: "Delete Backup",
                          size: 15,
                          color: AppStyle.warningColor)),
                ),
              ],
            ),
          )),
    );
  }
}
