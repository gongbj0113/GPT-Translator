import 'package:long_text_translator_gpt/model/model_pair.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';
import 'package:long_text_translator_gpt/service/chatgpt/chatgptclient.dart';

const _sysPrompt = """
target language will be provided between >>>>TargetLanguage and <<<<TargetLanguage.
original text that you have to translate will be provided between >>>>OriginalText and <<<<OriginalText.

Please translate the following text to the target language.

Your translation should be between >>>>Output and <<<<Output.

Example:
>>>>TargetLanguageen<<<<TargetLanguage
>>>>OriginalText안녕하세요,
어떻게 지내세요?
<<<<OriginalText

>>>>OutputHello,
How are you?
<<<<Output
""";

class InstantNoteTranslatorService {
  SettingsRepository _settingsRepository;

  InstantNoteTranslatorService(this._settingsRepository);

  String _generateUserPrompt(String text, String targetLanguage) {
    return """
>>>>TargetLanguage$targetLanguage<<<<TargetLanguage
>>>>OriginalText$text<<<<OriginalText
    """;
  }

  int _textLastIntersect(String text, String suffix) {
    int i = 1;
    while (i <= suffix.length) {
      if (text.endsWith(suffix.substring(0, i))) {
        return i;
      }
      i++;
    }
    return 0;
  }

  String _parseOutput(String text) {
    // find the text >>>>Output

    final int outputStart = text.indexOf(">>>>Output");

    if (outputStart == -1) {
      return "";
    }

    final afterText = text.substring(outputStart + 10);

    // find the text <<<<Output
    final int lastIntersect = _textLastIntersect(afterText, "<<<<Output");
    return afterText.substring(0, afterText.length - lastIntersect);
  }

  Stream<String> translate(
      String text, String targetLanguage, ModelPair model) async* {
    final ChatGPTClient client = ChatGPTClient(
      apiKey: _settingsRepository.settings.openAIApiKey,
      model: model.modelName,
      temperature: 0.1,
    );

    String output = "";
    final stream = client.sendMessageStream(
      _sysPrompt,
      _generateUserPrompt(text, targetLanguage),
    );

    await for (final message in stream) {
      output += message;

      yield _parseOutput(output);
    }

    yield _parseOutput(output);
  }
}
