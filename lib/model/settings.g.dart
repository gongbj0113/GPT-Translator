// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      openAIApiKey: json['openAIApiKey'] as String,
      isOpenAIApiKeySet: json['isOpenAIApiKeySet'] as bool,
      models: (json['models'] as List<dynamic>)
          .map((e) => ModelPair.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultTargetLanguage: json['defaultTargetLanguage'] as String,
      workingDirectory: json['workingDirectory'] as String,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'openAIApiKey': instance.openAIApiKey,
      'isOpenAIApiKeySet': instance.isOpenAIApiKeySet,
      'models': instance.models,
      'defaultTargetLanguage': instance.defaultTargetLanguage,
      'workingDirectory': instance.workingDirectory,
    };
