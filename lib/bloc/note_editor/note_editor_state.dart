// part of 'note_editor_bloc.dart';
//
// enum NoteEditorViewMode {
//   original_translated,
//   translated_original,
//   vertical_original_translated,
//   translated_only,
// }
//
// class NoteEditorState extends Equatable {
//   const NoteEditorState({
//     this.viewMode = NoteEditorViewMode.original_translated,
//     required this.note,
//     this.realTimeTranslations = const [],
//   });
//
//   final NoteEditorViewMode viewMode;
//   final TranslationNote note;
//   final List<TranslationNoteRecord> realTimeTranslations;
//
//   get isRealtimeTranslating => realTimeTranslations.isNotEmpty;
//
//   @override
//   List<Object> get props => [
//         viewMode,
//         note,
//         realTimeTranslations,
//       ];
//
//   NoteEditorState copyWith({
//     TranslationNote? note,
//     NoteEditorViewMode? viewMode,
//     List<TranslationNoteRecord>? realTimeTranslations,
//   }) {
//     return NoteEditorState(
//       viewMode: viewMode ?? this.viewMode,
//       note: note ?? this.note,
//       realTimeTranslations: realTimeTranslations ?? this.realTimeTranslations,
//     );
//   }
// }
