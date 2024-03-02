import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secure_private_notes/cubit/auth/auth_cubit.dart';
import 'package:secure_private_notes/cubit/lock/app_lock_cubit.dart';
import 'package:secure_private_notes/cubit/notes/note_cubit.dart';
import 'package:secure_private_notes/cubit/theme/theme_cubit.dart';
import 'package:secure_private_notes/model/note_model.dart';
import 'package:secure_private_notes/strings/app_strings.dart';
import 'package:secure_private_notes/view/notes/notes_screen.dart';
import 'view/passcode/passcode_view.dart';

void main() async {
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  await Hive.openBox<NoteModel>(boxName);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<NoteCubit>(
        create: (context) => NoteCubit(),
      ),
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
      ),
      BlocProvider<ThemeCubit>(
        create: (context) => ThemeCubit()..getCurrentTheme(),
      ),
      BlocProvider<AppLockCubit>(
        create: (context) => AppLockCubit(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Secure Private Notes',
          theme: state,
          home: const PasscodeView(routeTo: NotesScreen()),
        );
      },
    );
  }
}
