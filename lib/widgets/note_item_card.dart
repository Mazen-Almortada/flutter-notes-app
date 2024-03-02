import 'package:flutter/material.dart';
import '../style/app_style.dart';

class NoteItemCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String date;
  final IconData favoriteIcon;
  final void Function()? onTapDelete;
  final void Function()? onTapFavorite;
  final void Function()? onTapNote;
  const NoteItemCard(
      {Key? key,
      required this.onTapNote,
      required this.favoriteIcon,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.onTapFavorite,
      required this.onTapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapNote,
      child: Center(
          child: Container(
        padding: const EdgeInsets.only(top: 1),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  offset: const Offset(0.1, 1),
                  color: AppStyle.fontsColor)
            ],
            color: AppStyle.secondaryColor,
            borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 60,
              child: ListTile(
                title: Text(
                  title,
                  style: AppStyle.thirdFont
                      .copyWith(fontSize: 18, color: AppStyle.fontsColor),
                ),
                subtitle: Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: AppStyle.secondaryFont
                      .copyWith(color: AppStyle.subTitleColor),
                ),
                contentPadding: const EdgeInsets.only(left: 10),
                trailing: IconButton(
                  onPressed: onTapFavorite,
                  icon: Icon(
                    favoriteIcon,
                    color: AppStyle.fontsColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: AppStyle.primaryFont
                        .copyWith(color: AppStyle.subTitleColor),
                  ),
                  IconButton(
                    onPressed: onTapDelete,
                    icon: Icon(
                      Icons.delete_outlined,
                      color: AppStyle.warningColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
