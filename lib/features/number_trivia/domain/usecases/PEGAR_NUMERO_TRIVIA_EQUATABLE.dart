import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import '../respositories/TRIVIA_REPOSITORIO_DOMAIN.dart';

class GetConcreteNumberTrivia implements UseCase<Numero__Trivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, Numero__Trivia>?> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.Numero);
  }
}

class Params extends Equatable {
  final int Numero;

  Params({required this.Numero});

  @override
  List<Object?> get props => [Numero];
}
