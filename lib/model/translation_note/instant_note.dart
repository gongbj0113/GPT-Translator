import 'package:json_annotation/json_annotation.dart';
import 'package:long_text_translator_gpt/model/model_pair.dart';

part 'instant_note.g.dart';

@JsonSerializable()
class InstantNoteRecord {
  final String id;
  final String originalText;
  final String translatedLanguage;
  final String translatedText;
  final ModelPair model;
  final bool isErrorOccurred;

  InstantNoteRecord({
    required this.id,
    required this.originalText,
    required this.translatedLanguage,
    required this.translatedText,
    required this.model,
    required this.isErrorOccurred,
  });

  InstantNoteRecord.empty()
      : id = '',
        originalText = '',
        translatedLanguage = '',
        translatedText = '',
        model = const ModelPair(modelLabel: "", modelName: ""),
        isErrorOccurred = false;

  InstantNoteRecord copyWith({
    String? id,
    String? originalText,
    String? translatedLanguage,
    String? translatedText,
    ModelPair? model,
    bool? isErrorOccurred,
  }) {
    return InstantNoteRecord(
      id: id ?? this.id,
      originalText: originalText ?? this.originalText,
      translatedLanguage: translatedLanguage ?? this.translatedLanguage,
      translatedText: translatedText ?? this.translatedText,
      model: model ?? this.model,
      isErrorOccurred: isErrorOccurred ?? this.isErrorOccurred,
    );
  }

  factory InstantNoteRecord.fromJson(Map<String, dynamic> json) =>
      _$InstantNoteRecordFromJson(json);

  Map<String, dynamic> toJson() => _$InstantNoteRecordToJson(this);
}

@JsonSerializable()
class InstantNote {
  final String title;
  final String targetLanguage;

  final List<InstantNoteRecord> records;

  InstantNote({
    required this.title,
    required this.records,
    required this.targetLanguage,
  });

  InstantNote copyWith({
    String? title,
    String? content,
    List<InstantNoteRecord>? records,
    String? targetLanguage,
  }) {
    return InstantNote(
      title: title ?? this.title,
      records: records ?? this.records,
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }

  factory InstantNote.fromJson(Map<String, dynamic> json) =>
      _$InstantNoteFromJson(json);

  Map<String, dynamic> toJson() => _$InstantNoteToJson(this);
}
