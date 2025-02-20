import 'package:test/test.dart';

int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  String delimiter = ","; // Default delimiter
  if (numbers.startsWith("//")) {
    int delimiterEnd = numbers.indexOf("\n");
    if (delimiterEnd == -1) {
      throw FormatException("Invalid delimiter format");
    }
    delimiter = numbers.substring(2, delimiterEnd);
    numbers = numbers.substring(delimiterEnd + 1);
  }

  String cleanedNumbers = numbers.replaceAll("\n", delimiter);
  List<String> numStrings = cleanedNumbers.split(delimiter);

  List<int> nums = [];
  List<int> negatives = [];

  for (String numStr in numStrings) {
    if (numStr.isNotEmpty) {
      try {
        int num = int.parse(numStr.trim());
        if (num < 0) {
          negatives.add(num);
        }
        nums.add(num);
      } catch (e) {
        throw FormatException("Invalid number format: $numStr");
      }
    }
  }

  if (negatives.isNotEmpty) {
    throw Exception("negative numbers not allowed ${negatives.join(",")}");
  }

  return nums.fold(0, (sum, num) => sum + num);
}

void main() {
  group('String Calculator', () {
    test('Empty string should return 0', () {
      expect(add(""), 0);
    });

    test('Single number should return itself', () {
      expect(add("1"), 1);
      expect(add("5"), 5);
    });

    test('Two numbers should return their sum', () {
      expect(add("1,5"), 6);
      expect(add("2,3"), 5);
    });

    test('Multiple numbers should return their sum', () {
      expect(add("1,2,3,4,5"), 15);
    });

    test('custom delimiter', () {
      expect(add("//;\n1;2"), 3);
    });

    test('Negative number should throw exception', () {
      expect(() => add("-1,2"), throwsA(isA<Exception>()));
    });

    test('Invalid number format throws exception', () {
      expect(() => add("1,a"), throwsA(isA<FormatException>()));
    });

  });
}