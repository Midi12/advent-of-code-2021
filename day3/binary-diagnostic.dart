import 'dart:math';

import '../base.dart';

class BinaryLine {
  final List<int> data;

  BinaryLine(this.data);
}

class BinaryLineParser implements BaseParser {
  @override
  T cast<T>(String value) {
    return BinaryLine(value.runes.map((i) => int.parse(String.fromCharCode(i))).toList()) as T;
  }

}

BinaryLineParser parser = BinaryLineParser();

List<List<int>> rowsToColumns(List<List<int>> rows) {
  List<List<int>> columns = <List<int>>[];

  for (int i = 0; i < rows.length; i++) {
    for (int j = 0; j < rows[i].length; j++) {
      if (j == columns.length) {
        columns.add(<int>[]);
      }

      columns[j].add(rows[i][j]);
    }
  }

  return columns;
}

extension ToDecimal on List<int> {
  int toDecimal() {
    int l = this.length - 1;
    return this.map((e) => (e * pow(2, l--) as int)).reduce((a, b) => a + b);
  }
}

main() {
  pushParser(BinaryLine, parser);

  String path = 'input.txt';
  List<List<int>> rows = parseInputFile<BinaryLine>(path).map((e) => e.data).toList();

  List<List<int>> columns = rowsToColumns(rows);

  // figure out most common bit
  List<int> mostCommonBits = <int>[];
  List<int> mostCommonBitsInverted = <int>[];
  for (int i = 0; i < columns.length; i++) {
    // since we work with bits we can use addition to find the most common bit
    int sum = columns[i].reduce((a, b) => a + b);
    mostCommonBits.add(sum * 2 > columns[i].length ? 1 : 0);
    mostCommonBitsInverted.add(sum * 2 < columns[i].length ? 1 : 0);
  }

  int gamma = mostCommonBits.toDecimal();
  int epsilon = mostCommonBitsInverted.toDecimal();

  print('Part One answer ? ${gamma * epsilon}');

  int getMostCommonBit(List<List<int>> source, int position, int reference) {
    List<List<int>> columns = rowsToColumns(source);
    int sum = columns[position].reduce((a, b) => a + b);
    return sum * 2 >= columns[position].length ? reference : 1 - reference;
  }

  List<List<int>> o2Candidates = new List<List<int>>.from(rows);
  for (int i = 0; i < columns.length; i++) {
    o2Candidates = o2Candidates.where((bits) => bits[i] == getMostCommonBit(o2Candidates, i, 1)).toList();
    if (o2Candidates.length <= 1) {
      break;
    }
  }

  int o2rating = o2Candidates[0].toDecimal();

  List<List<int>> co2Candidates = new List<List<int>>.from(rows);
  for (int i = 0; i < columns.length; i++) {
    co2Candidates = co2Candidates.where((bits) => bits[i] == getMostCommonBit(co2Candidates, i, 0)).toList();
    if (co2Candidates.length <= 1) {
      break;
    }
  }

  int co2rating = co2Candidates[0].toDecimal();

  print('Part Two answer ? ${o2rating * co2rating}');
}