import 'package:Gleison_CLEAN_ARCH/core/usecases/usecase.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/domain/usecases/RANDOMIZAR_BOTAO_USECASE.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import 'package:Gleison_CLEAN_ARCH/features/TRIVIA_APP_TESTE/domain/respositories/TRIVIA_REPOSITORIO_DOMAIN.dart';

import 'get_random_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetRandomNumberTrivia usecase;
  late Numero__Trivia tNumberTrivia;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
    tNumberTrivia = Numero__Trivia(Numero: 1, Texto: 'test');
  });

  test(
    'should get trivia from the repository',
    () async {
      //arange

      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      final result = await usecase(NoParams());
      //assert
      expect(result, equals(Right(tNumberTrivia)));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
