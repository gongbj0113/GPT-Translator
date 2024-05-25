import 'package:json_annotation/json_annotation.dart';
import 'package:long_text_translator_gpt/model/model_pair.dart';
import 'package:long_text_translator_gpt/model/text_split_configuration.dart';

part 'document_note_consecutive.g.dart';

@JsonSerializable()
class DocumentNoteConsecutiveConfiguration {
  final TextSplitConfiguration textSplitConfiguration;
  final ModelPair model;
  final String targetLanguage;

  const DocumentNoteConsecutiveConfiguration({
    required this.textSplitConfiguration,
    required this.model,
    required this.targetLanguage,
  });

  factory DocumentNoteConsecutiveConfiguration.fromJson(
          Map<String, dynamic> json) =>
      _$DocumentNoteConsecutiveConfigurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DocumentNoteConsecutiveConfigurationToJson(this);
}

@JsonSerializable()
class DocumentNoteConsecutiveRecord {
  final int index;
  final String translatedText;
  final bool isFinished;

  const DocumentNoteConsecutiveRecord({
    required this.index,
    required this.translatedText,
    required this.isFinished,
  });

  factory DocumentNoteConsecutiveRecord.fromJson(Map<String, dynamic> json) =>
      _$DocumentNoteConsecutiveRecordFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentNoteConsecutiveRecordToJson(this);
}

@JsonSerializable()
class DocumentNoteConsecutive {
  final DocumentNoteConsecutiveConfiguration configuration;
  final String originalText;
  final List<DocumentNoteConsecutiveRecord> records;
  final bool hasRemaining;
  final bool isErrorOccurred;
  final bool isFinished;

  const DocumentNoteConsecutive({
    required this.configuration,
    required this.originalText,
    required this.records,
    required this.hasRemaining,
    required this.isErrorOccurred,
    required this.isFinished,
  });

  factory DocumentNoteConsecutive.fromJson(Map<String, dynamic> json) =>
      _$DocumentNoteConsecutiveFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentNoteConsecutiveToJson(this);
}
