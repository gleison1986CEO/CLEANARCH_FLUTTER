import 'package:bloc_test/bloc_test.dart';
import 'package:Gleison_CLEAN_ARCH/core/error/failures.dart';
import 'package:Gleison_CLEAN_ARCH/core/usecases/usecase.dart';
import 'package:Gleison_CLEAN_ARCH/core/util/input_converter.dart';
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/domain/usecases/PEGAR_NUMERO_TRIVIA_EQUATABLE.dart';
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/domain/usecases/RANDOMIZAR_BOTAO_USECASE.dart';
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/presentation/bloc/TRIVIA_BLOC.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia(1);
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () async {
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = Numero__Trivia(Texto: 'test trivia', Numero: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the inpus is invalid.', () async* {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final expected = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      //assert later
      expectLater(bloc, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should get data from the concrete usecase', () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetRandomNumberTrivia(any));

      //assert
      verify(mockGetConcreteNumberTrivia(Params(Numero: tNumberParsed)));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully',
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      //assert later
      final expeted = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expeted = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
        'should emits [Loading, Error] with a proper message for the error when getting data fails',
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expeted = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = Numero__Trivia(Texto: 'test trivia', Numero: 1);

    test('should get data from the random usecase', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));

      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully',
        () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      //assert later
      final expeted = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expeted = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });

    test(
        'should emits [Loading, Error] with a proper message for the error when getting data fails',
        () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expeted = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expeted));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });
  });
}
