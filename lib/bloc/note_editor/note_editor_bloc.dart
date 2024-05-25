// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../model/translation_note/translation_note.dart';
// import '../../service/translator/translator_service.dart';
//
// part 'note_editor_event.dart';
//
// part 'note_editor_state.dart';
//
// class NoteEditorBloc extends Bloc<NoteEditorEvent, NoteEditorState> {
//   final TranslatorService _translatorService;
//
//   NoteEditorBloc(
//       {required TranslatorService translatorService,
//       required TranslationNote note})
//       : _translatorService = translatorService,
//         super(NoteEditorState(note: note)) {
//     on<SetViewModeNoteEditorEvent>(_onSetViewMode);
//     on<StartTranslationNoteEditorEvent>(_onStartTranslation);
//     on<StopTranslationNoteEditorEvent>(_onStopTranslation);
//   }
//
//   void _onSetViewMode(
//       SetViewModeNoteEditorEvent event, Emitter<NoteEditorState> emit) {
//     emit(state.copyWith(viewMode: event.viewMode));
//   }
//
//   Future<void> _startTranslation(Emitter<NoteEditorState> emit) async {
//     while (!_translatorService.isFinished(state.note)) {
//       List<TranslationNoteRecord> newRecords = [];
//
//       var stream = _translatorService.translateNextStep(state.note);
//       await for (List<TranslationNoteRecord> records in stream) {
//         emit(state.copyWith(
//           realTimeTranslations: records,
//         ));
//         newRecords = records;
//       }
//       final newNote = state.note.copyWith(
//         records: [...state.note.records, ...newRecords],
//       );
//
//       emit(state.copyWith(note: newNote, realTimeTranslations: []));
//     }
//   }
//
//   Future<void> _onStopTranslation(StopTranslationNoteEditorEvent event,
//       Emitter<NoteEditorState> emit) async {
//     _translatorService.forceStop();
//     emit(state.copyWith(
//       realTimeTranslations: [],
//     ));
//   }
//
//   void _onStartTranslation(StartTranslationNoteEditorEvent event,
//       Emitter<NoteEditorState> emit) async {
//     await _startTranslation(emit);
//   }
// }
