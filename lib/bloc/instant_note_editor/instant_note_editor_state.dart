part of 'instant_note_editor_cubit.dart';

class InstantNoteEditorState extends Equatable {
  final InstantNote instantNote;
  final String inputText;
  final bool isTitleEditable;
  final String editingTitle;
  final List<Tuple2<String, InstantNoteTranslatorService>> services;
  final ModelPair selectedModelPair;

  const InstantNoteEditorState({
    required this.instantNote,
    required this.inputText,
    required this.isTitleEditable,
    required this.editingTitle,
    required this.services,
    required this.selectedModelPair,
  });

  bool isTranslating(String id) =>
      services.any((element) => element.item1 == id);

  factory InstantNoteEditorState.initial(
      InstantNote instantNote, Settings settings) {
    return InstantNoteEditorState(
      instantNote: instantNote,
      inputText: "",
      isTitleEditable: false,
      editingTitle: instantNote.title,
      services: [],
      selectedModelPair: settings.models.first,
    );
  }

  InstantNoteEditorState copyWith({
    InstantNote? instantNote,
    String? inputText,
    bool? isTitleEditable,
    String? editingTitle,
    List<Tuple2<String, InstantNoteTranslatorService>>? services,
    ModelPair? selectedModelPair,
  }) {
    return InstantNoteEditorState(
      instantNote: instantNote ?? this.instantNote,
      inputText: inputText ?? this.inputText,
      isTitleEditable: isTitleEditable ?? this.isTitleEditable,
      editingTitle: editingTitle ?? this.editingTitle,
      services: services ?? this.services,
      selectedModelPair: selectedModelPair ?? this.selectedModelPair,
    );
  }

  @override
  List<Object> get props => [
        instantNote,
        inputText,
        isTitleEditable,
        editingTitle,
        services,
        selectedModelPair
      ];
}
