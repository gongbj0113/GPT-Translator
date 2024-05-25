import 'package:json_annotation/json_annotation.dart';

part 'text_split_configuration.g.dart';

@JsonSerializable()
class TextSplitConfiguration {
  final int maxContentLength;
  final int maxAfterMarginLength;
  final int maxBeforeMarginCount;

  const TextSplitConfiguration({
    required this.maxContentLength,
    required this.maxAfterMarginLength,
    required this.maxBeforeMarginCount,
  });

  factory TextSplitConfiguration.fromJson(Map<String, dynamic> json) =>
      _$TextSplitConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$TextSplitConfigurationToJson(this);
}
