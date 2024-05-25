import 'dart:math';

import 'package:long_text_translator_gpt/model/text_split_configuration.dart';
import 'package:tuple/tuple.dart';

class TextSplitService {
  static List<Tuple2<String, String>> splitText(
      String text, TextSplitConfiguration configuration) {
    final List<Tuple2<String, String>> parts = [];

    int start = 0;

    while (start < text.length) {
      final int contentEnd =
          min(start + configuration.maxContentLength, text.length);
      final int marginEnd =
          min(contentEnd + configuration.maxAfterMarginLength, text.length);

      final String content = text.substring(start, contentEnd);
      final String margin = text.substring(contentEnd, marginEnd);

      parts.add(Tuple2(content, margin));

      start = marginEnd;
    }

    return parts;
  }
}
