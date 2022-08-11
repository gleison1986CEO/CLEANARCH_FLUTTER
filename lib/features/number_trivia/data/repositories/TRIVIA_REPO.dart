import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/TRIVIA_DATASOURCE.dart';
import '../datasources/TRIVIA_REMOTE_SOURCE.dart';
import '../models/TRIVIA_MODEL.dart';
import '../../domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import '../../../../core/error/failures.dart';

import '../../domain/respositories/TRIVIA_REPOSITORIO_DOMAIN.dart';
import 'package:dartz/dartz.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Numero__Trivia>> getConcreteNumberTrivia(
      int Numero) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(Numero)!;
    });
  }

  @override
  Future<Either<Failure, Numero__Trivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, Numero__Trivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
