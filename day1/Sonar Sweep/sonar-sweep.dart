import 'dart:io';
import 'dart:convert';

main() {
  String path = 'input.txt';

  List<int> depths = File(path).readAsLinesSync()
    .map((line) => int.parse(line)).toList();

  int answer = 0;
  int? lastDepth = null;

  for (int i = 0; i < depths.length; i++) {
    int depth = depths[i];

    if (lastDepth != null) {
      if (depth > lastDepth) {
        answer++;
      }
    }

    lastDepth = depth;
  }

  print('Part one answer ? $answer');

  answer = 0;
  int? lastSum = 0;

  const int window_size = 3;
  int _getWindowSum(List<int> source, int index) {
    List<int> window = <int>[]..addAll(source.getRange(index, index + window_size));
    return window.reduce((a, b) => a + b);
  }

  for (int i = 0; i < depths.length; i++) {
    if (i >= depths.length - window_size) {
      break;
    }

    int sum = _getWindowSum(depths, i);

    if (lastSum != null) {
      if (sum > lastSum) {
        answer++;
      }
    }

    lastSum = sum;
  }

  print('Part two answer ? $answer');
}