// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_note_consecutive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentNoteConsecutiveConfiguration
    _$DocumentNoteConsecutiveConfigurationFromJson(Map<String, dynamic> json) =>
        DocumentNoteConsecutiveConfiguration(
          textSplitConfiguration: TextSplitConfiguration.fromJson(
              json['textSplitConfiguration'] as Map<String, dynamic>),
          model: ModelPair.fromJson(json['model'] as Map<String, dynamic>),
          targetLanguage: json['targetLanguage'] as String,
        );

Map<String, dynamic> _$DocumentNoteConsecutiveConfigurationToJson(
        DocumentNoteConsecutiveConfiguration instance) =>
    <String, dynamic>{
      'textSplitConfiguration': instance.textSplitConfiguration,
      'model': instance.model,
      'targetLanguage': instance.targetLanguage,
    };

DocumentNoteConsecutiveRecord _$DocumentNoteConsecutiveRecordFromJson(
        Map<String, dynamic> json) =>
    DocumentNoteConsecutiveRecord(
      index: (json['index'] as num).toInt(),
      translatedText: json['translatedText'] as String,
      isFinished: json['isFinished'] as bool,
    );

Map<String, dynamic> _$DocumentNoteConsecutiveRecordToJson(
        DocumentNoteConsecutiveRecord instance) =>
    <String, dynamic>{
      'index': instance.index,
      'translatedText': instance.translatedText,
      'isFinished': instance.isFinished,
    };

DocumentNoteConsecutive _$DocumentNoteConsecutiveFromJson(
        Map<String, dynamic> json) =>
    DocumentNoteConsecutive(
      configuration: DocumentNoteConsecutiveConfiguration.fromJson(
          json['configuration'] as Map<String, dynamic>),
      originalText: json['originalText'] as String,
      records: (json['records'] as List<dynamic>)
          .map((e) =>
              DocumentNoteConsecutiveRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasRemaining: json['hasRemaining'] as bool,
      isErrorOccurred: json['isErrorOccurred'] as bool,
      isFinished: json['isFinished'] as bool,
    );

Map<String, dynamic> _$DocumentNoteConsecutiveToJson(
        DocumentNoteConsecutive instance) =>
    <String, dynamic>{
      'configuration': instance.configuration,
      'originalText': instance.originalText,
      'records': instance.records,
      'hasRemaining': instance.hasRemaining,
      'isErrorOccurred': instance.isErrorOccurred,
      'isFinished': instance.isFinished,
    };
