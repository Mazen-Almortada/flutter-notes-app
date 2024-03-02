import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/theme/theme_cubit.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/theme/theme_preferences.dart';
import 'package:secure_private_notes/widgets/small_text.dart';

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  @override
  void initState() {
    super.initState();
    checkMode();
  }

  String? mode;

  Future<void> checkMode() async {
    var appMode = await ThemePreferences.isDark() ? "dark" : "light";
    setState(() {
      mode = appMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          activeColor: AppStyle.greenColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 0,
          ),
          title: const SmallTexts(text: "Dark Mode", size: 15),
          value: "dark",
          groupValue: mode,
          onChanged: (value) async {
            if (mode == "light") {
              BlocProvider.of<ThemeCubit>(context).switchTheme();
            }
            setState(() {
              mode = value!;
            });
          },
        ),
        RadioListTile(
          activeColor: AppStyle.greenColor,
          title: const SmallTexts(text: "Light Mode", size: 15),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          value: "light",
          groupValue: mode,
          onChanged: (value) async {
            if (mode == "dark") {
              BlocProvider.of<ThemeCubit>(context).switchTheme();
            }
            setState(() {
              mode = value!;
            });
          },
        ),
      ],
    );
  }
}
