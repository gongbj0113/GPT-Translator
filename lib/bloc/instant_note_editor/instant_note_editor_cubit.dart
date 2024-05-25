import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:long_text_translator_gpt/model/model_pair.dart';
import 'package:long_text_translator_gpt/model/settings.dart';
import 'package:long_text_translator_gpt/model/translation_note/instant_note.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';
import 'package:long_text_translator_gpt/repository/TranslationNoteRepository.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

import '../../service/translator/instant_note_translator_service.dart';
import 'package:super_clipboard/super_clipboard.dart';

part 'instant_note_editor_state.dart';

class InstantNoteEditorCubit extends Cubit<InstantNoteEditorState> {
  final SettingsRepository _settingsRepository;
  final _uuid = const Uuid();
  final void Function(InstantNote instantNote) _onSave;
  final void Function(String title) _onTitleChange;
  final void Function() _onDelete;

  InstantNoteEditorCubit({
    required InstantNote instantNote,
    required SettingsRepository settingsRepository,
    required TranslationNoteRepository translationNoteRepository,
    required void Function(InstantNote instantNote) onSave,
    required void Function(String title) onTitleChange,
    required void Function() onDelete,
  })  : _settingsRepository = settingsRepository,
        _onSave = onSave,
        _onTitleChange = onTitleChange,
        _onDelete = onDelete,
        super(InstantNoteEditorState.initial(
          instantNote,
          settingsRepository.settings,
        ));

  void updateInputText(String text) {
    emit(state.copyWith(inputText: text));
  }

  void updateInputTargetLanguage(String targetLanguage) {
    emit(state.copyWith(
      instantNote: state.instantNote.copyWith(
        targetLanguage: targetLanguage,
      ),
    ));
  }

  void reuseInstantNoteInput(String id) {
    final index =
        state.instantNote.records.indexWhere((element) => element.id == id);
    if (index == -1) {
      return;
    }
    final record = state.instantNote.records[index];

    emit(state.copyWith(
      inputText: record.originalText,
    ));
  }

  void reuseInstantNoteOutput(String id) {
    final index =
        state.instantNote.records.indexWhere((element) => element.id == id);

    if (index == -1) {
      return;
    }

    final record = state.instantNote.records[index];
    emit(state.copyWith(
      inputText: record.translatedText,
      instantNote: state.instantNote.copyWith(
        targetLanguage: record.translatedLanguage,
      ),
    ));
  }

  Future<void> copyInstantNoteInput(String id) async {
    final index =
        state.instantNote.records.indexWhere((element) => element.id == id);
    if (index == -1) {
      return;
    }
    final record = state.instantNote.records[index];

    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return; // Clipboard API is not supported on this platform.
    }
    final item = DataWriterItem();
    item.add(Formats.plainText(record.originalText));
    await clipboard.write([item]);
  }

  Future<void> copyInstantNoteOutput(String id) async {
    final index =
        state.instantNote.records.indexWhere((element) => element.id == id);

    if (index == -1) {
      return;
    }

    final record = state.instantNote.records[index];

    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return; // Clipboard API is not supported on this platform.
    }
    final item = DataWriterItem();
    item.add(Formats.plainText(record.translatedText));
    await clipboard.write([item]);
  }

  void startEditingTitle() {
    emit(
      state.copyWith(
        isTitleEditable: true,
        editingTitle: state.instantNote.title,
      ),
    );
  }

  void cancelEditingTitle() {
    emit(
      state.copyWith(
        isTitleEditable: false,
        editingTitle: "",
      ),
    );
  }

  void saveEditingTitle() {
    _onTitleChange(state.editingTitle);
    emit(
      state.copyWith(
        isTitleEditable: false,
        editingTitle: "",
        instantNote: state.instantNote.copyWith(
          title: state.editingTitle,
        ),
      ),
    );
  }

  void deleteInstantNote() {
    _onDelete();
  }

  void deleteRecord(String id) {
    final List<InstantNoteRecord> newRecords =
        List<InstantNoteRecord>.from(state.instantNote.records);
    final index = newRecords.indexWhere((element) => element.id == id);

    if (index == -1) {
      return;
    }
    newRecords.remove(
      newRecords[index],
    );
    emit(state.copyWith(
      instantNote: state.instantNote.copyWith(records: newRecords),
    ));
  }

  void setModelPair(ModelPair modelPair) {
    emit(state.copyWith(selectedModelPair: modelPair));
  }

  Future<void> startTranslation() async {
    final inputText = state.inputText;
    emit(state.copyWith(
      inputText: "",
    ));

    print(
        "Start translation with input text: $inputText, target language: ${state.instantNote.targetLanguage}, model: ${state.selectedModelPair}");

    // Create new instant note
    final id = _uuid.v4();
    InstantNoteRecord newRecord = InstantNoteRecord(
      id: id,
      originalText: inputText,
      translatedLanguage: state.instantNote.targetLanguage,
      translatedText: "",
      model: state.selectedModelPair,
      isErrorOccurred: false,
    );

    final InstantNoteTranslatorService newService =
        InstantNoteTranslatorService(_settingsRepository);

    emit(state.copyWith(
      services: [
        ...state.services,
        Tuple2(id, newService),
      ],
    ));

    Stream<String> stream = newService.translate(
        inputText, state.instantNote.targetLanguage, state.selectedModelPair);

    emit(state.copyWith(
      instantNote: state.instantNote.copyWith(
        records: [...state.instantNote.records, newRecord],
      ),
    ));
    try {
      await for (String text in stream) {
        newRecord = newRecord.copyWith(translatedText: text);
        final newRecords =
            List<InstantNoteRecord>.from(state.instantNote.records);

        final index = newRecords.indexWhere((element) => element.id == id);

        if (index != -1) {
          newRecords[index] = newRecord;
          final newInstantNote =
              state.instantNote.copyWith(records: newRecords);
          emit(state.copyWith(
            instantNote: newInstantNote,
          ));

          _onSave(newInstantNote);
        }
      }
    } catch (e) {
      newRecord = newRecord.copyWith(isErrorOccurred: true);

      final newRecords =
          List<InstantNoteRecord>.from(state.instantNote.records);

      final index = newRecords.indexWhere((element) => element.id == id);

      if (index != -1) {
        newRecords[index] = newRecord;
        final newInstantNote = state.instantNote.copyWith(records: newRecords);
        emit(state.copyWith(
          instantNote: newInstantNote,
        ));

        _onSave(newInstantNote);

        return;
      }
    }
  }
}
