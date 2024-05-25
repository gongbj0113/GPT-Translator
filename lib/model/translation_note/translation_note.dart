import 'package:json_annotation/json_annotation.dart';

import 'instant_note.dart';
import 'document_note_consecutive.dart';
import 'document_note_sentence_unit.dart';

part 'translation_note.g.dart';

enum TranslationNoteType {
  instantNote,
  documentNoteConsecutive,
  documentNoteSentenceUnit,
}

@JsonSerializable()
class TranslationNote {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  final TranslationNoteType type;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String title;

  final InstantNote? instantNote;
  final DocumentNoteConsecutive? documentNoteConsecutive;
  final DocumentNoteSentenceUnit? documentNoteSentenceUnit;

  const TranslationNote({
    this.id = "",
    required this.type,
    this.title = "",
    this.instantNote,
    this.documentNoteConsecutive,
    this.documentNoteSentenceUnit,
  });

  TranslationNote copyWith({
    String? id,
    TranslationNoteType? type,
    String? title,
    InstantNote? instantNote,
    DocumentNoteConsecutive? documentNoteConsecutive,
    DocumentNoteSentenceUnit? documentNoteSentenceUnit,
  }) {
    return TranslationNote(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      instantNote: instantNote ?? this.instantNote,
      documentNoteConsecutive:
          documentNoteConsecutive ?? this.documentNoteConsecutive,
      documentNoteSentenceUnit:
          documentNoteSentenceUnit ?? this.documentNoteSentenceUnit,
    );
  }

  factory TranslationNote.fromJson(Map<String, dynamic> json) =>
      _$TranslationNoteFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationNoteToJson(this);
}
