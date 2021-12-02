import 'dart:io';

abstract class BaseParser {
  T cast<T>(String value);
}

Map<String, BaseParser> _parsers = <String, BaseParser>{};

void pushParser(String typeName, BaseParser parser) => _parsers.putIfAbsent(typeName, () => parser);

extension Cast on String {
  T cast<T>() {
    String typeName = '${T}';
    if (!_parsers.containsKey(typeName)) {
      throw ArgumentError('Key $typeName does not exists');
    }

    return _parsers[typeName]!.cast<T>(this);
  }
}

List<T> parseInputFile<T>(String path) => File(path).readAsLinesSync()
    .map((line) => line.cast<T>()).toList();

T? enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value);
}