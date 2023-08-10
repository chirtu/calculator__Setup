import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen()
    );
  }
}


class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          _expression = evalExpression(_expression);
        } catch (e) {
          _expression = '';
        }
      } else if (buttonText == 'C') {
        _expression = '';
      } else {
        _expression += buttonText;
      }
    });
  }

  String evalExpression(String expression) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toString();
    } catch (e) {
      return '';
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            onPrimary: Colors.white,
          ),
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(.7),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                _expression,
                style:  GoogleFonts.roboto(fontSize: 40.0,color: Colors.white),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('C'),
                    _buildButton('%'),
                    _buildButton('/'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('*'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('='),
                  ],
                ),
              ],
            ),
          ),
          Align(alignment: Alignment.bottomRight, child: TextButton(onPressed: () {  }, child: Text("Buy me a coffee", style: GoogleFonts.roboto(color: Colors.white),),)),
        ],
      ),
    );
  }
}