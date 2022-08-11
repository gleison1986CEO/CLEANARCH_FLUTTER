import 'package:equatable/equatable.dart';

class Numero__Trivia extends Equatable {
  final String Texto;
  final int Numero;

  Numero__Trivia({
    required this.Texto,
    required this.Numero,
  });

  @override
  List<Object?> get props => [Texto, Numero];
}
