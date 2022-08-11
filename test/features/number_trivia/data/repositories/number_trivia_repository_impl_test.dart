import 'package:Gleison_CLEAN_ARCH/core/error/exceptions.dart';
import 'package:Gleison_CLEAN_ARCH/core/error/failures.dart';
import 'package:Gleison_CLEAN_ARCH/core/network/network_info.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/data/datasources/TRIVIA_DATASOURCE.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/data/datasources/TRIVIA_REMOTE_SOURCE.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/data/models/TRIVIA_MODEL.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/data/repositories/TRIVIA_REPO.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

// class MockNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([NetworkInfo])
// @GenerateMocks([NumberTriviaRemoteDataSource])
@GenerateMocks([
  NumberTriviaRemoteDataSource
], customMocks: [
  MockSpec<NumberTriviaRemoteDataSource>(
      as: #MockNumberTriviaRemoteDataSourceForTest,
      returnNullOnMissingStub: true),
])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(Texto: 'test trivia', Numero: tNumber);
    final Numero__Trivia tNumberTrivia = tNumberTriviaModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTrivia)));
      });
      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test(
          'should return serverfailure when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(Texto: 'test trivia', Numero: 123);
    final Numero__Trivia tNumberTrivia = tNumberTriviaModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getRandomNumberTrivia();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });
      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test(
          'should return serverfailure when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
