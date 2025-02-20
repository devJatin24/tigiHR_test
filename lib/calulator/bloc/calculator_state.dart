part of 'calculator_cubit.dart';

@immutable
sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {}
 class CalculatorLoaded extends CalculatorState {
  String msg;
  CalculatorLoaded(this.msg);
}
 class CalculatorError extends CalculatorState {
  String error;
  CalculatorError(this.error);
}
 class CalculatorLoading extends CalculatorState {}
