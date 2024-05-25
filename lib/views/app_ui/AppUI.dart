import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/model/translation_note/translation_note.dart';
import 'package:long_text_translator_gpt/views/app_ui/SideBar.dart';
import 'package:long_text_translator_gpt/views/instant_note_editor/InstantNoteEditorUI.dart';

import '../../bloc/main/main_cubit.dart';
import '../../bloc/startup/startup_cubit.dart';
import '../startup/StartupUI.dart';

class AppUI extends StatelessWidget {
  const AppUI({super.key});

  Widget buildMain(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        if (state.selectedNote == null) {
          return const StartupUI();
        }
        if (state.selectedNote?.type == TranslationNoteType.instantNote &&
            state.instantNoteCubit != null) {
          return BlocProvider.value(
            value: state.instantNoteCubit!,
            child: const InstantNoteEditorUI(),
          );
        }
        return const StartupUI();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF8F8F8),
      child: SizedBox.expand(
        child: Row(
          children: [
            const SizedBox(width: 200, child: SideBar()),
            Container(
              width: 1,
              height: double.infinity,
              color: const Color(0xFFE0E0E0),
            ),
            Expanded(
              child: BlocSelector<MainCubit, MainState, StartupCubit>(
                selector: (state) => state.startupCubit,
                builder: (context, cubit) => BlocProvider.value(
                  value: cubit,
                  child: buildMain(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
