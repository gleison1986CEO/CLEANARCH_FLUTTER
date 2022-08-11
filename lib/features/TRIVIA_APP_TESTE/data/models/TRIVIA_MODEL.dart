import '../../domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';

class NumberTriviaModel extends Numero__Trivia {
  NumberTriviaModel({required String Texto, required int Numero})
      : super(Texto: Texto, Numero: Numero);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      Texto: json['text'],
      Numero: (json['number']).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': Texto, 'number': Numero};
  }
}
