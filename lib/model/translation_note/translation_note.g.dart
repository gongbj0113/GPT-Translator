// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationNote _$TranslationNoteFromJson(Map<String, dynamic> json) =>
    TranslationNote(
      type: $enumDecode(_$TranslationNoteTypeEnumMap, json['type']),
      instantNote: json['instantNote'] == null
          ? null
          : InstantNote.fromJson(json['instantNote'] as Map<String, dynamic>),
      documentNoteConsecutive: json['documentNoteConsecutive'] == null
          ? null
          : DocumentNoteConsecutive.fromJson(
              json['documentNoteConsecutive'] as Map<String, dynamic>),
      documentNoteSentenceUnit: json['documentNoteSentenceUnit'] == null
          ? null
          : DocumentNoteSentenceUnit.fromJson(
              json['documentNoteSentenceUnit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TranslationNoteToJson(TranslationNote instance) =>
    <String, dynamic>{
      'type': _$TranslationNoteTypeEnumMap[instance.type]!,
      'instantNote': instance.instantNote,
      'documentNoteConsecutive': instance.documentNoteConsecutive,
      'documentNoteSentenceUnit': instance.documentNoteSentenceUnit,
    };

const _$TranslationNoteTypeEnumMap = {
  TranslationNoteType.instantNote: 'instantNote',
  TranslationNoteType.documentNoteConsecutive: 'documentNoteConsecutive',
  TranslationNoteType.documentNoteSentenceUnit: 'documentNoteSentenceUnit',
};
