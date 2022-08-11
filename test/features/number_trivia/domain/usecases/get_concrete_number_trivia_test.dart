import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/domain/respositories/TRIVIA_REPOSITORIO_DOMAIN.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/domain/usecases/PEGAR_NUMERO_TRIVIA_EQUATABLE.dart';

import 'get_random_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetConcreteNumberTrivia usecase;
  late int tNumber;
  late Numero__Trivia tNumberTrivia;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    tNumberTrivia = Numero__Trivia(Numero: 1, Texto: 'test');
    tNumber = 1;
  });

  test(
    'should get trivia for the number from the repository',
    () async {
      //arange

      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      final result = await usecase(Params(Numero: tNumber));
      //assert
      expect(result, equals(Right(tNumberTrivia)));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
