import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import 'package:dartz/dartz.dart';

import '../respositories/TRIVIA_REPOSITORIO_DOMAIN.dart';

class GetRandomNumberTrivia implements UseCase<Numero__Trivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, Numero__Trivia>?> call(NoParams noParams) async {
    return await repository.getRandomNumberTrivia();
  }
}
