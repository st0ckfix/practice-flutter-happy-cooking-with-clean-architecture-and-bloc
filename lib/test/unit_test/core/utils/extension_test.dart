import 'package:flutter_test/flutter_test.dart';
import 'package:happy_cooking/core/utils/extention.dart';

void main() {
  test("Extention should return null when input is null", () {
    String? input;
    String? output;

    input.let((it) => output = "Hello World!");

    expect(output, isNull);
  });

  test("Extension should return value if input is not null", () {
    String? input = "Hello World!";
    String? output;

    input.let((it) => output = "Hello World!");

    expect(output, isNotNull);
  });

  test("Extension should return correct value if input is not null", () {
    String? input = "Hello World!";
    String? output;

    input.let((it) => output = it);

    expect(output, equals(input));
  });
}
