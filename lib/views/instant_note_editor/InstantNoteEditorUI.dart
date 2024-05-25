import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/bloc/instant_note_editor/instant_note_editor_cubit.dart';
import 'package:long_text_translator_gpt/model/model_pair.dart';
import 'package:long_text_translator_gpt/model/translation_note/instant_note.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';
import 'package:long_text_translator_gpt/views/instant_note_editor/InputCardUI.dart';
import 'package:long_text_translator_gpt/views/instant_note_editor/TranslationRecordCardUI.dart';

import '../../bloc/main/main_cubit.dart';

class InstantNoteEditorUI extends StatelessWidget {
  const InstantNoteEditorUI({super.key});

  Widget buildModelItem({
    required ModelPair model,
    required bool isSelected,
    Function()? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(4),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ]
              : []),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
              model.modelLabel,
              style: TextStyle(
                color: isSelected ? Colors.black : const Color(0xFF707070),
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildModelSelector(BuildContext context) {
    final models = context.read<SettingsRepository>().settings.models;

    return BlocSelector<InstantNoteEditorCubit, InstantNoteEditorState,
            ModelPair>(
        selector: (state) => state.selectedModelPair,
        builder: (context, modelPair) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < models.length; i++)
                Padding(
                  padding:
                      EdgeInsets.only(right: i == models.length - 1 ? 0 : 4),
                  child: buildModelItem(
                    model: models[i],
                    isSelected: models[i] == modelPair,
                    onTap: () {
                      context
                          .read<InstantNoteEditorCubit>()
                          .setModelPair(models[i]);
                    },
                  ),
                ),
            ],
          );
        });
  }

  List<Widget> buildHeader(BuildContext context) {
    return [
      Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7F7F7),
              Color(0x00F7F7F7),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        child: Row(
          children: [
            Image.asset("assets/images/instant.png", width: 18),
            const SizedBox(width: 8),
            BlocSelector<MainCubit, MainState, String>(
              selector: (state) => state.selectedNote?.title ?? "",
              builder: (context, title) {
                return Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(width: 36),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit_note_outlined, size: 16),
            ),
            const Expanded(child: SizedBox()),
            buildModelSelector(context),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                context.read<InstantNoteEditorCubit>().deleteInstantNote();
              },
              icon: const Icon(
                Icons.delete_sweep_outlined,
                size: 18,
                color: Color(0xFF5D5D5D),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget buildBody(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 26, right: 26, bottom: 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 20,
          ),
          child: BlocSelector<InstantNoteEditorCubit, InstantNoteEditorState,
              List<InstantNoteRecord>>(
            selector: (state) => state.instantNote.records,
            builder: (context, records) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...records.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: TranslationRecordCardUI(id: e.id),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 14),
                    child: InputCardUI(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          buildBody(context),
          ...buildHeader(context),
        ],
      ),
    );
  }
}
