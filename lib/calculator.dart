import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  return customButton(
                    buttonList[index],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      splashColor: const Color(0xFF1d2630),
      onTap: () {
        setState(() {
          handlButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3),
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return const Color.fromARGB(255, 104, 204, 159);
    }
    return const Color(0xFF1d2630);
  }

  handlButtons(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }
    if (isOperand(text)) {
      // Check if the last character in userInput is an operand
      if (userInput.isNotEmpty && isOperand(userInput[userInput.length - 1])) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    }
    userInput = userInput + text;
  }

  bool isOperand(String text) {
    return text == "/" || text == "*" || text == "+" || text == "-";
  }

  bool isValidInput(String input) {
    // Check if the last character in input is an operand or not
    if (input.isNotEmpty && input[input.length - 1] == '*' ||
        input[input.length - 1] == '/' ||
        input[input.length - 1] == '+' ||
        input[input.length - 1] == '-') {
      return false;
    }
    return true;
  }

  String calculate() {
    try {
      // Remove leading and trailing operators
      userInput = userInput.replaceAll(RegExp(r'^[*/+|-]+'), '');
      userInput = userInput.replaceAll(RegExp(r'[*/+|-]+$'), '');

      // Split the expression by operators
      List<String> operands = userInput.split(RegExp(r'[*/+|-]'));

      // Split the expression by numbers
      List<String> operators = userInput.split(RegExp(r'[0-9]'));
      operators.removeWhere((element) => element.isEmpty);

      // Initialize the result with the first operand
      double result = double.parse(operands[0]);

      // Iterate over the operators and operands and perform calculations
      for (int i = 0; i < operators.length; i++) {
        if (operators[i] == '+') {
          result += double.parse(operands[i + 1]);
        } else if (operators[i] == '-') {
          result -= double.parse(operands[i + 1]);
        } else if (operators[i] == '*') {
          result *= double.parse(operands[i + 1]);
        } else if (operators[i] == '/') {
          result /= double.parse(operands[i + 1]);
        }
      }

      return result.toString();
    } catch (e) {
      return "Error";
    }
  }
}
