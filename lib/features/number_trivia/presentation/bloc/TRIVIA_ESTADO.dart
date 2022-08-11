part of 'TRIVIA_BLOC.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final Numero__Trivia trivia;

  Loaded({required this.trivia});
}

class Error extends NumberTriviaState {
  final String message;

  Error({required this.message});
}
