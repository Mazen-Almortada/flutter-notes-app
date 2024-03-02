import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/utils/date_formater.dart';
import 'package:secure_private_notes/widgets/app_bar.dart';
import 'package:secure_private_notes/widgets/custom_text_field.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';
import '../../cubit/notes/note_cubit.dart';
import '../../model/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  void formValidator() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String formatedDate = dateFormatter(DateTime.now());

      BlocProvider.of<NoteCubit>(context).addNote(
          NoteModel(title: title!, subTitle: subTitle!, date: formatedDate));

      BlocProvider.of<NoteCubit>(context).fetchNotes();
      Routes.back(context);
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey();
  String? title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back_ios,
        onTapLeading: () {
          Routes.back(context);
        },
        actionsIcon: Icons.save,
        onTapActions: () {
          formValidator();
        },
        title: const TitlesText(
          text: "Add new note",
          size: 20,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView(children: [
          Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
                  CustomTextFormField(
                      hint: "Enter title",
                      maxLines: 1,
                      onSaved: (value) {
                        title = value;
                      }),
                  CustomTextFormField(
                    hint: "Enter note",
                    onSaved: (value) {
                      subTitle = value;
                    },
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
