import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var operationField='';
  var result="";
  List<String> buttons=[
    'C','DEL','%','/',
    '9','8','7','*',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','ANS','=',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:Text ( 'Hit Calculator '),
      ),
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom:12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(operationField,style: TextStyle(fontSize: 20),)),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(result,style: TextStyle(fontSize: 20),)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top:4),
              padding: const EdgeInsets.all(14.0) ,
              child:Center (

                child: GridView.builder(
                  itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),// grid or net combine from 4 column
                    // ignore: missing_return
                    itemBuilder:(BuildContext context,int index){
                      if(index==0){//clear button
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              operationField="";
                            });
                          },
                            color: Colors.red,
                            textColor: Colors.white,
                            buttonText: buttons[index]);
                      }else if(index==1){//delete button
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              operationField=operationField.substring(0,operationField.length-1);
                            });
                          },
                            color: Colors.white,
                            textColor: Colors.red,
                            buttonText: buttons[index]);
                      }else if(index==buttons.length-1){
                        return MyButton(//equal button
                          buttonTapped: (){
                            setState(() {
                              equalPressed(operationField,context);
                            });
                          },
                            color: Colors.green,
                            textColor: Colors.white,
                            buttonText: buttons[index]);
                      }else {
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              operationField +=buttons[index];
                            });
                          },
                            color: isOperatr(buttons[index])
                                ? Colors.deepPurple
                                : Colors.white,
                            textColor: isOperatr(buttons[index])? Colors.white: Colors.deepPurple,
                            buttonText: buttons[index]);
                      }
                    }),
              )
              ,),
          ),
        ],
      ),
    );
  }

  bool isOperatr(String sympol){//check is button number or operation
    if(sympol=='%'||sympol=='/'||sympol=='*'||sympol=='-'
        ||sympol=='='||sympol=='+'){
      return true;
    }
      return false;

  }

  void equalPressed(String operation ,BuildContext context){
    var firstIndex=operation[0];
    if(firstIndex=='/'||firstIndex=='%'
        ||firstIndex=='*'||firstIndex=='+'||firstIndex=='-'){
      Scaffold.of(context).showSnackBar(new SnackBar(backgroundColor: Colors.red,
        content: new Text("you can't beging with sympol",style: TextStyle(color: Colors.white),),
      ));

    return;
    }
    Parser parser=Parser();
    Expression expression=parser.parse(operation);
    ContextModel cm=ContextModel();
    // Evaluate expression:
    double eval = expression.evaluate(EvaluationType.REAL, cm);
    result=eval.toString();

  }
}
