import 'package:json_annotation/json_annotation.dart';
import 'package:long_text_translator_gpt/model/model_pair.dart';
import 'package:long_text_translator_gpt/model/text_split_configuration.dart';

part 'document_note_sentence_unit.g.dart';

@JsonSerializable()
class DocumentNoteSentenceUnitConfiguration {
  final TextSplitConfiguration textSplitConfiguration;
  final ModelPair model;
  final String targetLanguage;

  const DocumentNoteSentenceUnitConfiguration({
    required this.textSplitConfiguration,
    required this.model,
    required this.targetLanguage,
  });

  factory DocumentNoteSentenceUnitConfiguration.fromJson(
          Map<String, dynamic> json) =>
      _$DocumentNoteSentenceUnitConfigurationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DocumentNoteSentenceUnitConfigurationToJson(this);
}

@JsonSerializable()
class TextPair {
  final String originalText;
  final String translatedText;

  const TextPair({
    required this.originalText,
    required this.translatedText,
  });

  factory TextPair.fromJson(Map<String, dynamic> json) =>
      _$TextPairFromJson(json);

  Map<String, dynamic> toJson() => _$TextPairToJson(this);
}

@JsonSerializable()
class DocumentNoteSentenceUnitRecord {
  final int index;
  final List<TextPair> pairs;
  final bool hasRemaining;
  final String remainingText;
  final bool isFinished;

  const DocumentNoteSentenceUnitRecord({
    required this.index,
    required this.pairs,
    required this.hasRemaining,
    required this.remainingText,
    required this.isFinished,
  });

  factory DocumentNoteSentenceUnitRecord.fromJson(Map<String, dynamic> json) =>
      _$DocumentNoteSentenceUnitRecordFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentNoteSentenceUnitRecordToJson(this);
}

@JsonSerializable()
class DocumentNoteSentenceUnit {
  final DocumentNoteSentenceUnitConfiguration configuration;
  final String originalText;
  final List<DocumentNoteSentenceUnitRecord> records;
  final bool isErrorOccurred;
  final bool isFinished;

  const DocumentNoteSentenceUnit({
    required this.configuration,
    required this.originalText,
    required this.records,
    required this.isErrorOccurred,
    required this.isFinished,
  });

  factory DocumentNoteSentenceUnit.fromJson(Map<String, dynamic> json) =>
      _$DocumentNoteSentenceUnitFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentNoteSentenceUnitToJson(this);
}
