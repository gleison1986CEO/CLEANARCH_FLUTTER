import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, Numero__Trivia>>? getConcreteNumberTrivia(int Numero);
  Future<Either<Failure, Numero__Trivia>>? getRandomNumberTrivia();
}
