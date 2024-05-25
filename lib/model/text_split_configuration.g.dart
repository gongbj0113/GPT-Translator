// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_split_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextSplitConfiguration _$TextSplitConfigurationFromJson(
        Map<String, dynamic> json) =>
    TextSplitConfiguration(
      maxContentLength: (json['maxContentLength'] as num).toInt(),
      maxAfterMarginLength: (json['maxAfterMarginLength'] as num).toInt(),
      maxBeforeMarginCount: (json['maxBeforeMarginCount'] as num).toInt(),
    );

Map<String, dynamic> _$TextSplitConfigurationToJson(
        TextSplitConfiguration instance) =>
    <String, dynamic>{
      'maxContentLength': instance.maxContentLength,
      'maxAfterMarginLength': instance.maxAfterMarginLength,
      'maxBeforeMarginCount': instance.maxBeforeMarginCount,
    };
