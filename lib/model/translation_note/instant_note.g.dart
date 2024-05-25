// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instant_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstantNoteRecord _$InstantNoteRecordFromJson(Map<String, dynamic> json) =>
    InstantNoteRecord(
      id: json['id'] as String,
      originalText: json['originalText'] as String,
      translatedLanguage: json['translatedLanguage'] as String,
      translatedText: json['translatedText'] as String,
      model: ModelPair.fromJson(json['model'] as Map<String, dynamic>),
      isErrorOccurred: json['isErrorOccurred'] as bool,
    );

Map<String, dynamic> _$InstantNoteRecordToJson(InstantNoteRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalText': instance.originalText,
      'translatedLanguage': instance.translatedLanguage,
      'translatedText': instance.translatedText,
      'model': instance.model,
      'isErrorOccurred': instance.isErrorOccurred,
    };

InstantNote _$InstantNoteFromJson(Map<String, dynamic> json) => InstantNote(
      title: json['title'] as String,
      records: (json['records'] as List<dynamic>)
          .map((e) => InstantNoteRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetLanguage: json['targetLanguage'] as String,
    );

Map<String, dynamic> _$InstantNoteToJson(InstantNote instance) =>
    <String, dynamic>{
      'title': instance.title,
      'targetLanguage': instance.targetLanguage,
      'records': instance.records,
    };
