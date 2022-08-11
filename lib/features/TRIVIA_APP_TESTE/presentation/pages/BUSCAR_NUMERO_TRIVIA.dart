import '../../domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import '../bloc/TRIVIA_BLOC.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  final String text;
  const NumberTriviaPage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent.shade700,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amberAccent.shade700,
          title: Text("Ola! " + text),
        ),
        body: SingleChildScrollView(child: buildBody(context)));
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(message: 'Buscar por API TRIVIA');
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return Container(
                        padding: EdgeInsets.all(4),
                        child: Card(
                            elevation: 44,
                            color: Colors.greenAccent.shade700,
                            child: Container(
                                padding: EdgeInsets.all(42),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      "Olá!! " + text + '  seu numero é: ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TriviaDisplay(numberTrivia: state.trivia),
                                    const Text(
                                        'Obrigado por testar nosso APP!'),
                                  ],
                                ))));
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Placeholder(),
                  );
                },
              ),
              SizedBox(height: 20),
              TriviaControls(),
              SizedBox(
                height: 30,
              ),
              Text('Obrigado por testar nosso APP!'),
              SizedBox(
                height: 10,
              ),
              Text('888h4ck.com 2022'),
            ],
          ),
        ),
      ),
    );
  }
}
