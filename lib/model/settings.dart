import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:long_text_translator_gpt/model/model_pair.dart';
import 'package:path_provider/path_provider.dart';

part 'settings.g.dart';

@JsonSerializable()
class Settings {
  final String openAIApiKey;
  final bool isOpenAIApiKeySet;
  final List<ModelPair> models;
  final String defaultTargetLanguage;
  final String workingDirectory;

  const Settings({
    required this.openAIApiKey,
    required this.isOpenAIApiKeySet,
    required this.models,
    required this.defaultTargetLanguage,
    required this.workingDirectory,
  });

  Settings copyWith({
    String? openAIApiKey,
    bool? isOpenAIApiKeySet,
    List<ModelPair>? models,
    String? defaultTargetLanguage,
    String? workingDirectory,
  }) {
    return Settings(
      openAIApiKey: openAIApiKey ?? this.openAIApiKey,
      isOpenAIApiKeySet: isOpenAIApiKeySet ?? this.isOpenAIApiKeySet,
      models: models ?? this.models,
      defaultTargetLanguage:
          defaultTargetLanguage ?? this.defaultTargetLanguage,
      workingDirectory: workingDirectory ?? this.workingDirectory,
    );
  }

  static Future<Settings> initial() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();

    final Directory workingDirectory = Directory(
      '${documentsDirectory.path}/long_text_translator_gpt',
    );

    if (!workingDirectory.existsSync()) {
      workingDirectory.createSync();
    }

    return Settings(
      openAIApiKey: '',
      isOpenAIApiKeySet: false,
      models: const [
        ModelPair(modelLabel: 'GPT-3.5', modelName: 'gpt-3.5-turbo'),
        ModelPair(modelLabel: 'GPT-4o', modelName: 'gpt-4o'),
      ],
      defaultTargetLanguage: '한국어',
      workingDirectory: workingDirectory.path,
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
