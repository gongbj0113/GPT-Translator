import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/bloc/instant_note_editor/instant_note_editor_cubit.dart';
import 'package:long_text_translator_gpt/model/translation_note/instant_note.dart';

class TranslationRecordCardUI extends StatelessWidget {
  final String id;

  const TranslationRecordCardUI({required this.id, super.key});

  Widget buildLeftCard(BuildContext context, InstantNoteRecord record) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SelectionArea(
                child: Text(
                  record.originalText,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {
                  context
                      .read<InstantNoteEditorCubit>()
                      .reuseInstantNoteInput(id);
                },
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.keyboard_double_arrow_down_rounded,
                  size: 16,
                  color: Color(0xFF5D5D5D),
                ),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<InstantNoteEditorCubit>()
                      .copyInstantNoteInput(id);
                },
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.copy_rounded,
                  size: 16,
                  color: Color(0xFF5D5D5D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRightCard(BuildContext context, InstantNoteRecord record) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SelectionArea(
                child: Text(
                  record.translatedText,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                decoration: const ShapeDecoration(
                  color: Color(0xFFF7F7F7),
                  shape: StadiumBorder(),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  record.translatedLanguage,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF5D5D5D),
                  ),
                ),
              ),
              record.isErrorOccurred
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Error",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {
                  context
                      .read<InstantNoteEditorCubit>()
                      .reuseInstantNoteOutput(id);
                },
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.keyboard_double_arrow_down_rounded,
                  size: 16,
                  color: Color(0xFF5D5D5D),
                ),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<InstantNoteEditorCubit>()
                      .copyInstantNoteOutput(id);
                },
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.copy_rounded,
                  size: 16,
                  color: Color(0xFF5D5D5D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InstantNoteEditorCubit, InstantNoteEditorState,
        InstantNoteRecord>(
      selector: (state) {
        return state.instantNote.records.firstWhere(
          (element) => element.id == id,
          orElse: () => InstantNoteRecord.empty(),
        );
      },
      builder: (context, state) {
        return SizedBox(
          height: 215,
          child: Row(
            children: [
              Expanded(
                child: buildLeftCard(context, state),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildRightCard(context, state),
              ),
            ],
          ),
        );
      },
    );
  }
}
