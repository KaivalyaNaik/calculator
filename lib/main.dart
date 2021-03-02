import 'package:flutter/material.dart';
import 'button.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var Input = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Calculator"),
      ), //AppBar
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child :Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        Input,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        onClick: () {
                          setState(() {
                            Input = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: Colors.black,
                      );
                    }

                    // +/- button
                    else if (index == 1) {
                      return MyButton(
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return MyButton(
                        onClick: () {
                          setState(() {
                            Input += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: Colors.black,
                      );
                    }
                    else if (index == 3) {
                      return MyButton(
                        onClick: () {
                          setState(() {
                            Input =
                                Input.substring(0, Input.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return MyButton(
                        onClick: () {
                          setState(() {
                            equal();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.black,
                      );
                    }

                    else {
                      return MyButton(
                        onClick: () {
                          setState(() {
                            Input += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index]) ? Colors.blueAccent : Colors.white,
                        textColor:  Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    )
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
  void equal() {
    String finalinput = Input;
    finalinput = Input.replaceAll('x', '*');
    Expression expression=Expression.parse(finalinput);
    final evaluator=const ExpressionEvaluator();
    var cntx={
      "1":1,
      "2":2,
      "3":3,
      "4":4,
      "5":5,
      "6":6,
      "7":7,
      "8":8,
      "9":9,
      "0":0,
    };
    var r=evaluator.eval(expression,cntx);
    setState(() {
      answer=r.toString();
    });

  }

}
