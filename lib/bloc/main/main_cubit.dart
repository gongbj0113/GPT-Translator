import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/bloc/instant_note_editor/instant_note_editor_cubit.dart';
import 'package:long_text_translator_gpt/bloc/startup/startup_cubit.dart';
import 'package:long_text_translator_gpt/model/translation_note/instant_note.dart';
import 'package:long_text_translator_gpt/model/translation_note/translation_note.dart';
import 'package:uuid/uuid.dart';

import '../../repository/SettingsRepository.dart';
import '../../repository/TranslationNoteRepository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  TranslationNoteRepository _translationNoteRepository;
  SettingsRepository _settingsRepository;

  MainCubit({
    required TranslationNoteRepository translationNoteRepository,
    required SettingsRepository settingsRepository,
  })  : _translationNoteRepository = translationNoteRepository,
        _settingsRepository = settingsRepository,
        super(
          MainState(
            instanceId: const Uuid().v4(),
            startupCubit: StartupCubit(
              settingsRepository: settingsRepository,
            ),
          ),
        ) {
    state.startupCubit.setOnStartInstantNote(_handleOnStartInstantNoteEditing);
    _init();
  }

  Future<void> _handleOnTitleChange(String title) async {
    if (state.selectedNote == null) {
      return;
    }

    final newNoteList = List<TranslationNoteListItem>.of(state.noteList);
    final index = newNoteList
        .indexWhere((element) => element.id == state.selectedNote?.id);

    if (index == -1) {
      return;
    }

    newNoteList[index] = newNoteList[index].copyWith(
      title: title,
    );

    final selectedNote = state.selectedNote;
    if (selectedNote != null) {
      await _translationNoteRepository.renameTranslationNote(
          id: selectedNote.id, newTitle: title);
      emit(state.copyWith(noteList: newNoteList));
    }
  }

  void _handleOnSaveInstantNote(InstantNote instantNote) {
    final selectedNote = state.selectedNote;
    if (selectedNote == null) {
      return;
    }
    _translationNoteRepository.saveTranslationNote(
        id: selectedNote.id,
        note: selectedNote.copyWith(
          instantNote: instantNote,
        ));
  }

  void _handleOnDeleteNote() {
    final selectedNote = state.selectedNote;
    if (selectedNote == null) {
      return;
    }
    _translationNoteRepository.deleteTranslationNote(id: selectedNote.id);
    final newNoteList = List<TranslationNoteListItem>.of(state.noteList);
    newNoteList.removeWhere((element) => element.id == selectedNote.id);
    emit(state.copyWith(
      isNullSelectedNote: true,
      noteList: newNoteList,
    ));
  }

  Future<void> _handleOnStartInstantNoteEditing(InstantNote instantNote) async {
    final translationNote =
        await _translationNoteRepository.createTranslationNote(
            title: "새로운 Instant Note",
            note: TranslationNote(
              type: TranslationNoteType.instantNote,
              instantNote: instantNote,
            ));

    final newNoteList = List<TranslationNoteListItem>.of(state.noteList);
    newNoteList.insert(
      0,
      TranslationNoteListItem(
        id: translationNote.id,
        title: "새로운 Instant Note",
      ),
    );

    final instantNoteCubit = InstantNoteEditorCubit(
      instantNote: instantNote,
      settingsRepository: _settingsRepository,
      translationNoteRepository: _translationNoteRepository,
      onTitleChange: _handleOnTitleChange,
      onSave: _handleOnSaveInstantNote,
      onDelete: _handleOnDeleteNote,
    );

    emit(state.copyWith(
      selectedNote: translationNote,
      instantNoteCubit: instantNoteCubit,
      noteList: newNoteList,
    ));
  }

  Future<void> _init() async {
    emit(state.copyWith(isNoteListLoading: true));
    final result = await _translationNoteRepository.getTranslationNotes();
    emit(state.copyWith(isNoteListLoading: false, noteList: result));
  }

  Future<void> selectNoteListItem(String id) async {
    final note = await _translationNoteRepository.getTranslationNoteById(id);

    if (note == null) {
      return;
    }

    if (note.type == TranslationNoteType.instantNote) {
      final newInstantNoteCubit = InstantNoteEditorCubit(
        instantNote: note.instantNote!,
        settingsRepository: _settingsRepository,
        translationNoteRepository: _translationNoteRepository,
        onTitleChange: _handleOnTitleChange,
        onSave: _handleOnSaveInstantNote,
        onDelete: _handleOnDeleteNote,
      );
      emit(
        state.copyWith(
          selectedNote: note,
          instantNoteCubit: newInstantNoteCubit,
        ),
      );
    }
  }

  void goToStartUp() {
    state.startupCubit.init();
    emit(state.copyWith(isNullSelectedNote: true));
  }

  void reloadApp() {
    emit(state.copyWith(instanceId: const Uuid().v4()));
  }
}
