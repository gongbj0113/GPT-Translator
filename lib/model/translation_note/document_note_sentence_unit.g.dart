// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_note_sentence_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentNoteSentenceUnitConfiguration
    _$DocumentNoteSentenceUnitConfigurationFromJson(
            Map<String, dynamic> json) =>
        DocumentNoteSentenceUnitConfiguration(
          textSplitConfiguration: TextSplitConfiguration.fromJson(
              json['textSplitConfiguration'] as Map<String, dynamic>),
          model: ModelPair.fromJson(json['model'] as Map<String, dynamic>),
          targetLanguage: json['targetLanguage'] as String,
        );

Map<String, dynamic> _$DocumentNoteSentenceUnitConfigurationToJson(
        DocumentNoteSentenceUnitConfiguration instance) =>
    <String, dynamic>{
      'textSplitConfiguration': instance.textSplitConfiguration,
      'model': instance.model,
      'targetLanguage': instance.targetLanguage,
    };

TextPair _$TextPairFromJson(Map<String, dynamic> json) => TextPair(
      originalText: json['originalText'] as String,
      translatedText: json['translatedText'] as String,
    );

Map<String, dynamic> _$TextPairToJson(TextPair instance) => <String, dynamic>{
      'originalText': instance.originalText,
      'translatedText': instance.translatedText,
    };

DocumentNoteSentenceUnitRecord _$DocumentNoteSentenceUnitRecordFromJson(
        Map<String, dynamic> json) =>
    DocumentNoteSentenceUnitRecord(
      index: (json['index'] as num).toInt(),
      pairs: (json['pairs'] as List<dynamic>)
          .map((e) => TextPair.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasRemaining: json['hasRemaining'] as bool,
      remainingText: json['remainingText'] as String,
      isFinished: json['isFinished'] as bool,
    );

Map<String, dynamic> _$DocumentNoteSentenceUnitRecordToJson(
        DocumentNoteSentenceUnitRecord instance) =>
    <String, dynamic>{
      'index': instance.index,
      'pairs': instance.pairs,
      'hasRemaining': instance.hasRemaining,
      'remainingText': instance.remainingText,
      'isFinished': instance.isFinished,
    };

DocumentNoteSentenceUnit _$DocumentNoteSentenceUnitFromJson(
        Map<String, dynamic> json) =>
    DocumentNoteSentenceUnit(
      configuration: DocumentNoteSentenceUnitConfiguration.fromJson(
          json['configuration'] as Map<String, dynamic>),
      originalText: json['originalText'] as String,
      records: (json['records'] as List<dynamic>)
          .map((e) => DocumentNoteSentenceUnitRecord.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      isErrorOccurred: json['isErrorOccurred'] as bool,
      isFinished: json['isFinished'] as bool,
    );

Map<String, dynamic> _$DocumentNoteSentenceUnitToJson(
        DocumentNoteSentenceUnit instance) =>
    <String, dynamic>{
      'configuration': instance.configuration,
      'originalText': instance.originalText,
      'records': instance.records,
      'isErrorOccurred': instance.isErrorOccurred,
      'isFinished': instance.isFinished,
    };
