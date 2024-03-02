import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/notes/note_cubit.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/view/notes/add_note_screen.dart';
import 'package:secure_private_notes/widgets/app_bar.dart';
import 'package:secure_private_notes/view/notes/notes_list_view.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';
import '../../widgets/drawer.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).fetchNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: const CustomDrawer(),
        appBar: CustomAppBar(
          drawerBuilder: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu,
                    size: 25, color: Theme.of(context).iconTheme.color),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actionsIcon: Icons.add,
          onTapActions: () {
            Routes.to(context, const AddNoteScreen());
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TitlesText(
              text: "Notes",
              size: 30,
            ),
            SizedBox(
              height: 10,
            ),
            NotesListView(),
          ],
        ),
      ),
    );
  }
}
