// Mocks generated by Mockito 5.0.16 from annotations
// in Gleison_CLEAN_ARCH/test/features/number_trivia/presentation/bloc/number_trivia_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:Gleison_CLEAN_ARCH/core/error/failures.dart' as _i6;
import 'package:Gleison_CLEAN_ARCH/core/usecases/usecase.dart' as _i9;
import 'package:Gleison_CLEAN_ARCH/core/util/input_converter.dart' as _i10;
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart'
    as _i7;
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/domain/respositories/TRIVIA_REPOSITORIO_DOMAIN.dart'
    as _i2;
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/domain/usecases/PEGAR_NUMERO_TRIVIA_EQUATABLE.dart'
    as _i4;
import 'package:Gleison_CLEAN_ARCH/features/number_trivia/domain/usecases/RANDOMIZAR_BOTAO_USECASE.dart'
    as _i8;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeNumberTriviaRepository_0 extends _i1.Fake
    implements _i2.NumberTriviaRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetConcreteNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteNumberTrivia extends _i1.Mock
    implements _i4.GetConcreteNumberTrivia {
  MockGetConcreteNumberTrivia(any) {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.NumberTriviaRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeNumberTriviaRepository_0())
          as _i2.NumberTriviaRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Numero__Trivia>?> call(
          _i4.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, _i7.Numero__Trivia>?>.value())
          as _i5.Future<_i3.Either<_i6.Failure, _i7.Numero__Trivia>?>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetRandomNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomNumberTrivia extends _i1.Mock
    implements _i8.GetRandomNumberTrivia {
  MockGetRandomNumberTrivia() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.NumberTriviaRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeNumberTriviaRepository_0())
          as _i2.NumberTriviaRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Numero__Trivia>?> call(
          _i9.NoParams? noParams) =>
      (super.noSuchMethod(Invocation.method(#call, [noParams]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, _i7.Numero__Trivia>?>.value())
          as _i5.Future<_i3.Either<_i6.Failure, _i7.Numero__Trivia>?>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i10.InputConverter {
  MockInputConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Either<_i6.Failure, int> stringToUnsignedInteger(String? string) =>
      (super.noSuchMethod(Invocation.method(#stringToUnsignedInteger, [string]),
              returnValue: _FakeEither_1<_i6.Failure, int>(),
              returnValueForMissingStub: _FakeEither_1<_i6.Failure, int>())
          as _i3.Either<_i6.Failure, int>);
  @override
  String toString() => super.toString();
}
