import 'package:Gleison_CLEAN_ARCH/features/number_trivia/presentation/bloc/TRIVIA_BLOC.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            //fillColor: Colors.white70),
            hintText: 'Digite seu Numero',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            addConcrete();
          },
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent.shade700,
                  shadowColor: Colors.grey,
                  elevation: 13,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(100, 50),
                ),
                child: Text('Buscar Numero'),
                onPressed: addConcrete,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amberAccent.shade700,
                  shadowColor: Colors.grey,
                  elevation: 13,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(100, 50),
                ),
                child: Text('Randomizar'),
                onPressed: addRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void addConcrete() {
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForConcreteNumber(inputStr));
  }

  void addRandom() {
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumber());
  }
}
