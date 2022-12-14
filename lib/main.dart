import 'features/TRIVIA_APP_TESTE/domain/entities/TRIVIA_VARIAVEIS_ENTIDADE.dart';
import 'features/TRIVIA_APP_TESTE/presentation/pages/TRIVIA_DATA_NOME.dart';
import 'features/TRIVIA_APP_TESTE/presentation/pages/BUSCAR_NUMERO_TRIVIA.dart';

import 'injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: INICIO(),
    );
  }
}
