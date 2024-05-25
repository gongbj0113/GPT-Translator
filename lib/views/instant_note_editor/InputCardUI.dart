import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/bloc/instant_note_editor/instant_note_editor_cubit.dart';

class InputCardUI extends StatefulWidget {
  const InputCardUI({super.key});

  @override
  State<InputCardUI> createState() => _InputCardUIState();
}

class _InputCardUIState extends State<InputCardUI> {
  bool _isFirstBuild = true;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _targetLanguageController =
      TextEditingController();

  Widget buildGoButton({
    Function()? onTap,
  }) {
    return Container(
      width: 50,
      height: double.infinity,
      decoration: BoxDecoration(
        color: (const Color(0xFF7E82E4)).withAlpha(4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF7E82E4),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: const Center(
            child: Icon(Icons.arrow_right_alt_rounded,
                color: Color(0xFF7E82E4), size: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstBuild) {
      _isFirstBuild = false;
      _targetLanguageController.text = context
          .read<InstantNoteEditorCubit>()
          .state
          .instantNote
          .targetLanguage;
    }

    return BlocConsumer<InstantNoteEditorCubit, InstantNoteEditorState>(
        listener: (context, s) {
          if (s.inputText != _controller.text) {
            _controller.text = s.inputText;
          }
          if (s.instantNote.targetLanguage != _targetLanguageController.text) {
            _targetLanguageController.text = s.instantNote.targetLanguage;
          }
        },
        buildWhen: (p, n) => false,
        builder: (context, s) {
          return SizedBox(
            height: 215,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withAlpha(4),
                          offset: const Offset(0, 4),
                          blurRadius: 18,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            controller: _controller,
                            onChanged: (v) {
                              context
                                  .read<InstantNoteEditorCubit>()
                                  .updateInputText(v);
                            },
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'Enter text here',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'To',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D5D5D),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 108,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF7F7F7),
                                shape: StadiumBorder(),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: _targetLanguageController,
                                onChanged: (v) {
                                  context
                                      .read<InstantNoteEditorCubit>()
                                      .updateInputTargetLanguage(v);
                                },
                                style: const TextStyle(
                                  color: Color(0xFF5D5D5D),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                buildGoButton(onTap: () {
                  context.read<InstantNoteEditorCubit>().startTranslation();
                }),
              ],
            ),
          );
        });
  }
}
