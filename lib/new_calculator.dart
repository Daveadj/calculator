// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class NewCalculator extends StatefulWidget {
  const NewCalculator({super.key});

  @override
  _NewCalculatorState createState() => _NewCalculatorState();
}

class _NewCalculatorState extends State<NewCalculator> {
  String display = '';
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  double result = 0;

  void calculate() {
    switch (operand) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
    }
    setState(() {
      display = result.toString();
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            if (buttonText == 'C') {
              display = '';
              num1 = 0;
              num2 = 0;
              operand = '';
            } else if (buttonText == '+' ||
                buttonText == '-' ||
                buttonText == '*' ||
                buttonText == '/') {
              num1 = double.parse(display);
              operand = buttonText;
              display = '';
            } else if (buttonText == '=') {
              num2 = double.parse(display);
              calculate();
            } else {
              display += buttonText;
            }
          });
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                display,
                style: const TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          const Divider(),
          Row(
            children: <Widget>[
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('0'),
              buildButton('C'),
              buildButton('='),
              buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}
