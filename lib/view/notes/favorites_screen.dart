import 'package:flutter/material.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/widgets/app_bar.dart';
import 'notes_list_view.dart';
import '../../widgets/text_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back_ios,
        onTapLeading: () {
          Routes.back(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TitlesText(
            text: "Favorites",
            size: 30,
          ),
          SizedBox(
            height: 10,
          ),
          NotesListView(
            isFavoritesNotes: true,
          ),
        ],
      ),
    );
  }
}
