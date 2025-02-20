import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  add(String numbers) {
    try {
      emit(CalculatorLoading());
      if (numbers.isEmpty) {
        emit(CalculatorLoaded("Result: 0"));
      } else {
        String delimiter = ",";
        if (numbers.startsWith("//")) {
          int delimiterEnd = numbers.indexOf("\n");
          if (delimiterEnd == -1) {
            emit(CalculatorError("Invalid delimiter format"));
            return;
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
              emit(CalculatorError("Invalid number format: $numStr"));
              return;
            }
          }
        }

        if (negatives.isNotEmpty) {
          emit(CalculatorError(
              "Negative numbers not allowed ${negatives.join(",")}"));
        } else {
          var result = nums.fold(0, (sum, num) => sum + num);
          emit(CalculatorLoaded("Result: $result"));
        }
      }
    } catch (e) {
      emit(CalculatorError("Something went wrong"));
    }
  }
}
