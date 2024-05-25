import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/bloc/main/main_cubit.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';
import 'package:long_text_translator_gpt/repository/TranslationNoteRepository.dart';
import 'package:long_text_translator_gpt/views/app_ui/AppUI.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SettingsRepository settingsRepository = SettingsRepository();
  await settingsRepository.loadSettings();

  runApp(MyApp(
    settingsRepository: settingsRepository,
  ));
}

class MyApp extends StatelessWidget {
  SettingsRepository settingsRepository;
  late TranslationNoteRepository translationNoteRepository;

  MyApp({required this.settingsRepository, super.key}) {
    translationNoteRepository = TranslationNoteRepository(settingsRepository);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPT Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
        fontFamily: 'Pretendard',
      ),
      home: RepositoryProvider.value(
        value: settingsRepository,
        child: RepositoryProvider.value(
          value: translationNoteRepository,
          child: BlocProvider(
            create: (context) => MainCubit(
              translationNoteRepository: translationNoteRepository,
              settingsRepository: settingsRepository,
            ),
            child: const ReloadUI(),
          ),
        ),
      ),
    );
  }
}

class ReloadUI extends StatelessWidget {
  const ReloadUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainCubit, MainState, String>(
      selector: (state) => state.instanceId,
      builder: (context, id) {
        return AppUI(
          key: GlobalKey(),
        );
      },
    );
  }
}
