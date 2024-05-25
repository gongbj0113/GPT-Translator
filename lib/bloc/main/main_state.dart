part of 'main_cubit.dart';

final class MainState {
  final String instanceId;
  final TranslationNote? selectedNote;
  final StartupCubit startupCubit;
  final InstantNoteEditorCubit? instantNoteCubit;

  final bool isNoteListLoading;
  final List<TranslationNoteListItem> noteList;

  MainState({
    required this.instanceId,
    this.selectedNote,
    required this.startupCubit,
    this.instantNoteCubit,
    this.isNoteListLoading = false,
    this.noteList = const [],
  });

  MainState copyWith({
    String? instanceId,
    bool isNullSelectedNote = false,
    TranslationNote? selectedNote,
    StartupCubit? startupCubit,
    InstantNoteEditorCubit? instantNoteCubit,
    bool? isNoteListLoading,
    List<TranslationNoteListItem>? noteList,
  }) {
    return MainState(
      instanceId: instanceId ?? this.instanceId,
      selectedNote:
          isNullSelectedNote ? null : selectedNote ?? this.selectedNote,
      startupCubit: startupCubit ?? this.startupCubit,
      instantNoteCubit: instantNoteCubit ?? this.instantNoteCubit,
      isNoteListLoading: isNoteListLoading ?? this.isNoteListLoading,
      noteList: noteList ?? this.noteList,
    );
  }
}
