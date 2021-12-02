import '../base.dart';

enum Direction {
  forward,
  up,
  down
}

class DirectionInput {
  final Direction direction;
  final int amount;

  DirectionInput(this.direction, this.amount);
}

class DirectionInputParser implements BaseParser {
  @override
  T cast<T>(String value) {
    List<String> data = value.split(' ');
    return DirectionInput(enumFromString(Direction.values, data[0])!, int.parse(data[1])) as T;
  }

}

DirectionInputParser parser = DirectionInputParser();

main() {
  pushParser('DirectionInput', parser);

  String path = 'input.txt';
  List<DirectionInput> inputs = parseInputFile<DirectionInput>(path);

  int depth = 0;
  int position = 0;

  for (int i = 0; i < inputs.length; i++) {
    DirectionInput input = inputs[i];

    switch (input.direction) {
      case Direction.forward:
        position += input.amount;
        break;
      case Direction.up:
        depth -= input.amount;
        break;
      case Direction.down:
        depth += input.amount;
        break;
    }
  }

  print('Part One answer ? ${depth * position}');

  depth = 0;
  position = 0;
  int aim = 0;

  for (int i = 0; i < inputs.length; i++) {
    DirectionInput input = inputs[i];

    switch (input.direction) {
      case Direction.forward:
        position += input.amount;
        depth += aim * input.amount;
        break;
      case Direction.up:
        aim -= input.amount;
        break;
      case Direction.down:
        aim += input.amount;
        break;
    }
  }

  print('Part Two answer ? ${depth * position}');
}