import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";

  void onButtonPressed(String value) {
  setState(() {
    if (value == "C") {
      input = "";
    } else if (value == "=") {
      try {
        input = evaluateExpression(input);
      } catch (e) {
        input = "Error";
      }
    } else {
      input += value;
    }
  });
}

String evaluateExpression(String expression) {
  try {
    RegExp regex = RegExp(r'(\d+\.?\d*)|([+\-*/])');
    List<String> tokens = regex.allMatches(expression).map((m) => m.group(0)!).toList();

    if (tokens.length < 3) return expression;

    double num1 = double.parse(tokens[0]);
    String operator = tokens[1];
    double num2 = double.parse(tokens[2]);

    double result;
    switch (operator) {
      case '+': result = num1 + num2; break;
      case '-': result = num1 - num2; break;
      case '*': result = num1 * num2; break;
      case '/': result = num2 == 0 ? throw Exception("Cannot divide by zero") : num1 / num2; break;
      default: return "Error";
    }

    return result.toString();
  } catch (e) {
    return "Error";
  }
}

  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onButtonPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(input, style: const TextStyle(fontSize: 32)),
            ),
          ),
          Column(
            children: [
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("*")]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
              Row(children: [buildButton("0"), buildButton("C"), buildButton("="), buildButton("+")]),
            ],
          ),
        ],
      ),
    );
  }
}
