import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );

  }
}
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
    double firstnum=0.0;
    double secondnum=0.0;
    var input="";
    var output="";
    var operation="";
    var outputsize= 40.0;
    var hideInput= false;
    onbuttonclick(value){
      if(value=="AC"){
        input="";
        output="";
      }
      else if(value=="<--"){
        if(input.isNotEmpty){
        input=input.substring(0, input.length-1);
      }
      }
      else if(value=='='){
        if(input.isNotEmpty){
        var userinput= input;
        userinput= input.replaceAll("x", "*");
        Parser p= Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm= ContextModel();
        var finalValue= expression.evaluate(EvaluationType.REAL, cm);
        output=finalValue.toString();
        if(output.endsWith(".0")){
        output=output.substring(0, output.length-2);
      }
        }
        input=output;
        hideInput=true;
        outputsize=50.0;
      }
      else{
        input=input+value;
        outputsize=50.0;
        hideInput=false;

      }
      setState(() { });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator', style: TextStyle(fontSize: 16.0),), backgroundColor:Color.fromARGB(255, 6, 7, 7) ),
      backgroundColor: Color.fromARGB(255, 6, 7, 7),
      body:Column(
        children: [
            Divider(
            color: Color.fromARGB(255, 129, 128, 128),
            thickness: 4,
            // indent: 0.0, // Adjust the indentation as needed
            // endIndent: 20, 
            ),
          Expanded(
            child:Container(
              width: double.infinity,
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Text(
                hideInput ?"":input,  style: TextStyle(fontSize: 50.0, color: Colors.white),),
              SizedBox(height: 35.0,),
              Text(output, style: TextStyle(fontSize: outputsize, color: Colors.white), ),
              SizedBox(height: 35.0,),
            ]
            ),
            color:Colors.black26)),

          
          Row(
            children: [
              button(text: 'AC' , buttonbgcolor: Colors.deepOrange),
              button(text: '<--'),
              button(text: '%',),
              button(text: '/'),
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '*'),
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-'),
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+'),
            ],
          ),
          Row(
            children: [
              // button(text: ''),
              button(text: '0'),
              button(text: '.'),
              button(text: '=' ),
            ],
          ),
        ],
      ),
    );
  }

   Widget button({text  , tcolor = Colors.white, buttonbgcolor = Colors.orange}){
     
    return Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0),
                ),
                 padding: EdgeInsets.all(22),
//             backgroundColor: buttonColor,
                ),
              onPressed:() => onbuttonclick(text) ,
              child: Text(
                text,
                 style: TextStyle(fontSize: 20.0),),
               
              ),
               ),
             );
  }
}
