// THIS code is from https://github.com/alfianlosari/chatgpt_api_dart/tree/main?tab=MIT-1-ov-file#readme
// Author of this code: Alfian Losri

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'message.dart';
import 'stream_client.dart';

/// A class to interact with OpenAI ChatGPT Completions API
/// Support various models such as gpt-3.5-turbo, gpt-4, etc
final class ChatGPTClient {
  /// OpenAI ChatGPT Completions API Endpoint URL
  final url = Uri.https("api.openai.com", "/v1/chat/completions");

  /// OpenAI API Key which you can get from https://openai.com/api
  final String apiKey;

  /// GPT Model (gpt-3.5-turbo, gpt-4, etc) default to gpt-3.5-turbo
  final String model;

  /// Temperature, default to 0.5
  final double temperature;

  /// Initializer, API key is required
  ChatGPTClient(
      {required this.apiKey,
      this.model = "gpt-3.5-turbo",
      this.temperature = 0.5});

  Map<String, String> _getHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };
  }

  String _getBody(String sysprompt, String text, bool stream) {
    final body = {
      "model": model,
      "temperature": temperature,
      "messages":
          _generateMessages(sysprompt, text).map((e) => e.toMap()).toList(),
      "stream": stream
    };
    return jsonEncode(body);
  }

  List<Message> _generateMessages(String sysprompt, String prompt) {
    var messages = [Message(content: sysprompt, role: "system")] +
        [Message(content: prompt, role: "user")];

    return messages;
  }

  /// Send message to ChatGPT to a prompt asynchronously
  Future<String> sendMessage(String sysprompt, String text) async {
    final response = await http.Client().post(url,
        headers: _getHeaders(), body: _getBody(sysprompt, text, false));

    dynamic decodedResponse;
    if (response.contentLength != null) {
      decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    }

    final statusCode = response.statusCode;
    if (!(statusCode >= 200 && statusCode < 300)) {
      if (decodedResponse != null) {
        final errorMessage = decodedResponse["error"]["message"] as String;
        throw Exception("($statusCode) $errorMessage");
      }
      throw Exception(
          "($statusCode) Bad response ${response.reasonPhrase ?? ""}");
    }

    final choices = decodedResponse["choices"] as List;
    final choice = choices[0] as Map;
    final content = choice["message"]["content"] as String;
    return content;
  }

  // Send Message to ChatGPT and receives the streamed response in chunk
  Stream<String> sendMessageStream(String sysprompt, String text) async* {
    final request = http.Request("POST", url)..headers.addAll(_getHeaders());
    request.body = _getBody(sysprompt, text, true);

    final response = await StreamClient.instance.send(request);
    final statusCode = response.statusCode;
    final byteStream = response.stream;

    if (!(statusCode >= 200 && statusCode < 300)) {
      var error = "";
      await for (final byte in byteStream) {
        final decoded = utf8.decode(byte).trim();
        final map = jsonDecode(decoded) as Map;
        final errorMessage = map["error"]["message"] as String;
        error += errorMessage;
      }
      throw Exception(
          "($statusCode) ${error.isEmpty ? "Bad Response" : error}");
    }

    String buffer = "";
    WAIT:
    await for (final byte in byteStream) {
      var decoded = utf8.decode(byte);
      buffer += decoded;
      if (buffer.endsWith("\n")) {
        final strings = buffer.split("data: ");
        for (final string in strings) {
          final trimmedString = string.trim();
          if (trimmedString == "[DONE]") {
            break WAIT;
          }
          if (trimmedString.isNotEmpty) {
            final map = jsonDecode(trimmedString) as Map;
            final choices = map["choices"] as List;
            final delta = choices[0]["delta"] as Map;
            if (delta["content"] != null) {
              final content = delta["content"] as String;
              yield content;
            }
          }
        }
        buffer = "";
      }
    }
  }
}
