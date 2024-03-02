// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/notes/note_cubit.dart';
import 'package:secure_private_notes/model/note_model.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/view/notes/edit_note_screen.dart';
import 'package:secure_private_notes/widgets/custom_container.dart';
import 'package:secure_private_notes/widgets/note_item_card.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';

import '../../utils/alert_dialog.dart';

class NotesListView extends StatelessWidget {
  final bool isFavoritesNotes;
  const NotesListView({
    this.isFavoritesNotes = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(child: BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        List<NoteModel> notes = BlocProvider.of<NoteCubit>(context).notes!;
        notes = notes.reversed.toList();
        if (isFavoritesNotes) {
          notes = notes.where((element) => element.isFavorite == true).toList();
        }
        if (notes.isEmpty) {
          return ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset(
                  "images/nodata.png",
                  height: 200,
                  width: 180,
                ),
              ),
              Center(
                child: TitlesText(
                  text: "No Notes Yet",
                  size: 17,
                  color: AppStyle.fontsColor,
                  bold: false,
                ),
              ),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return NoteItemCard(
                  onTapNote: () {
                    Routes.to(context, EditNoteScreen(note: notes[index]));
                  },
                  key: Key(notes[index].key.toString()),
                  favoriteIcon:
                      notes[index].isFavorite ? Icons.star : Icons.star_border,
                  onTapFavorite: () {
                    BlocProvider.of<NoteCubit>(context)
                        .toggleFavorites(notes[index]);
                  },
                  onTapDelete: () {
                    DialogUtils.show(
                      context,
                      action: "Delete",
                      content: "Are you sure you want to delete note?",
                      onPressed: () {
                        BlocProvider.of<NoteCubit>(context)
                            .deleteNote(notes[index]);
                        Routes.back(context);
                      },
                    );
                  },
                  title: notes[index].title,
                  subTitle: notes[index].subTitle,
                  date: notes[index].date);
            },
          );
        }
      },
    ));
  }
}
