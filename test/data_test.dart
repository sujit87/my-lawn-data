import 'package:test/test.dart';

import 'package:data/data.dart';

// https://github.com/dart-lang/sdk/issues/39305
final Matcher throwsAssertionError = throwsA(isA<AssertionError>());

class NullData extends Data {
  @override
  List<Object> get props => null;
}

class EmptyData extends Data {
  @override
  List<Object> get props => [];
}

class ValuesData extends Data {
  final String one = 'one';
  final int two = 2;

  @override
  List<Object> get props => [one, two];
}

class ValuesDataB extends Data {
  final String oneone = 'one';
  final int twotwo = 2;

  @override
  List<Object> get props => [oneone, twotwo];
}

class ValuesNamesData extends Data {
  final String one = 'one';
  final int two = 2;

  @override
  List<Object> get props => [one, two];

  @override
  List<String> get propsNames => ['one', 'two'];
}

class ValuesNamesDataNoStringify extends Data {
  final String one = 'one';
  final int two = 2;

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [one, two];

  @override
  List<String> get propsNames => ['one', 'two'];
}

void main() {
  group('operators', () {
    test('equality', () {
      expect(
        NullData(),
        equals(NullData()),
      );
      expect(
        EmptyData(),
        equals(EmptyData()),
      );
      expect(
        ValuesData(),
        equals(ValuesData()),
      );
      expect(
        ValuesNamesData(),
        equals(ValuesNamesData()),
      );
      expect(
        ValuesData(),
        isNot(equals(ValuesNamesData())),
      );
      expect(
        ValuesData(),
        isNot(equals(ValuesDataB())),
      );
      expect(
        NullData(),
        isNot(equals(EmptyData())),
      );
    });
  });
  group('methods', () {
    test('toMap()', () {
      expect(
        () => NullData().toMap(),
        throwsAssertionError,
      );
      expect(
        () => EmptyData().toMap(),
        throwsAssertionError,
      );
      expect(
        () => ValuesData().toMap(),
        throwsAssertionError,
      );
      expect(
        () => ValuesDataB().toMap(),
        throwsAssertionError,
      );
      expect(
        ValuesNamesData().toMap(),
        equals({'one': 'one', 'two': 2}),
      );
    });
    test('toString()', () {
      expect(
        NullData().toString(),
        equals('NullData()'),
      );
      expect(
        EmptyData().toString(),
        equals('EmptyData()'),
      );
      expect(
        ValuesData().toString(),
        equals('ValuesData(one, 2)'),
      );
      expect(
        ValuesNamesData().toString(),
        equals('ValuesNamesData(one, 2)'),
      );
      expect(
        ValuesNamesDataNoStringify().toString(),
        equals('ValuesNamesDataNoStringify'),
      );
    });
  });
}
