import 'package:flutter/material.dart';

import 'BUSCAR_NUMERO_TRIVIA.dart';

void main() {
  runApp(MaterialApp(
    title: 'APP ARCH CLEAN GLEISON',
    home: INICIO(),
  ));
}

class INICIO extends StatefulWidget {
  @override
  _INICIOState createState() {
    return _INICIOState();
  }
}

class _INICIOState extends State<INICIO> {
  // this allows us to access the TextField text
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade700,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text('TRIVIA API',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text('888H4CK.COM | 2022 CLEAN CODE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10)),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: textFieldController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  filled: true,
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  //fillColor: Colors.white70),
                  hintText: 'Digite seu Nome Completo',
                ),
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.amberAccent.shade700,
              shadowColor: Colors.grey,
              elevation: 13,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(210, 60),
            ),
            child: Text('Continuar'),
            onPressed: () {
              _sendDataToSecondScreen(context);
            },
          ),
        ],
      ),
    );
  }

  // get the text in the TextField and start the Second Screen
  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend = textFieldController.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NumberTriviaPage(
            text: textToSend,
          ),
        ));
  }
}
