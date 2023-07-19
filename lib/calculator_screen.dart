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
    '=',
  ];
  ScrollController inputTextScrolController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // double thisScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            // height: thisScreenHeight * 0.3,
            height: 170,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              controller: inputTextScrolController,
              child: Text(
                userInput,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: buttonList.length,
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return CustomButton(buttonList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.black,
      onTap: () {
        setState(() {
          handleButtons(text);
          inputTextScrolController.animateTo(
              inputTextScrolController.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOutCirc);
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
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == '/' ||
        text == '+' ||
        text == '-' ||
        text == '*' ||
        text == '(' ||
        text == ')') {
      return Colors.red;
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == 'AC') {
      return Colors.red;
    }
    return Colors.black;
  }

  handleButtons(String text) {
    if (text == 'AC') {
      userInput = '';
      result = '0';
      return;
    }
    if (text == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == '=') {
      result = Calculate();
      userInput = result;
      if (result.endsWith('.0') || userInput.endsWith('.0')) {
        result = result.replaceAll('.0', '');
        userInput = userInput.replaceAll('.0', '');
        return;
      }
    }
    userInput = userInput + text;
  }

  // ignore: non_constant_identifier_names
  String Calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
