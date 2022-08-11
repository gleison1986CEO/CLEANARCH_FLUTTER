import '../../domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  final Numero__Trivia numberTrivia;
  const TriviaDisplay({Key? key, required this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(numberTrivia.Numero.toString(),
              style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.Texto,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
