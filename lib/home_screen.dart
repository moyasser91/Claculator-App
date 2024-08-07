import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

 final List<String>symbol = [
    'C',
    'Del',
    '%',
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
    '.',
    '0',
    'Ans',
    '=',
  ];
  String input = '' , output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        elevation: 0 ,
        title: const Text('Calculator',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.black),),
        leading: Icon(Icons.menu_sharp),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.calendar_month_outlined,size: 27,),),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(8),
                  width: double.infinity,
                  child:  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(input,style:const TextStyle(
                     fontSize: 40,
                     color: Colors.blue,
                    ),),
                  )),
            ),
          Expanded(
            child: Container(
              margin:const EdgeInsets.all(8),
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
             scrollDirection:  Axis.horizontal,
                child: Text(output,textAlign: TextAlign.right,style: TextStyle(
                fontSize:45 ,
                color: Colors.pinkAccent.shade700
                           ),),
              ))),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: symbol.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (context, index) {
                   return InkWell(
                     onTap: (){
                       if(symbol[index] == 'C')
                         {
                           input = '' ;
                           output = '' ;
                         }
                       else if(symbol[index] == 'Del')
                       {
                         input = input.substring(0 , input.length-1);
                       }
                       else if(symbol[index] == 'Ans')
                       {
                       input = output ;
                       output = '';
                       }else if(
                           symbol[index]=='%' ||
                           symbol[index]=='/' ||
                           symbol[index]=='*' ||
                           symbol[index]=='+' ||
                           symbol[index]=='-' ) {
                         if (input.endsWith('%')||
                             input.endsWith('/')||
                             input.endsWith('*')||
                             input.endsWith('+')||
                             input.endsWith('-')) {
                           null;
                         }
                         else {
                           input += symbol[index];

                         }
                       }
                       else if(symbol[index]=='=')
                         {
                           Expression exp = Parser().parse(input);
                           var result = exp.evaluate(EvaluationType.REAL, ContextModel());
                           output = result.toString();
                         }
                       else
                       {
                         input+=symbol[index];
                       }
                       setState(() {

                       });
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(25),
                         color:myBackGroundColor(symbol[index])),
                       margin:const EdgeInsets.all(4),
                       padding:const EdgeInsets.all(1),
                       alignment: Alignment.center,
                     child:
                     Text( symbol[index],textAlign: TextAlign.center, style: TextStyle( color: myTextColor(symbol[index]),fontSize: 22, fontWeight: FontWeight.bold),),
                     ),
                   );
                }),
          )
        ],
      )
      ,
    );
  }


  Color myTextColor(String text) {
    if (text == '%' ||
        text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == 'C' ||
        text == 'Del' ||
        text == '=') {
      return Colors.white;
    }
    else {
      return Colors.black;
    }
  }
 Color myBackGroundColor(String text)
 {
   if(text == 'C')
   {
     return Colors.teal ;
   }
   else if (text == 'Del')
   {
     return Colors.deepOrangeAccent.shade100 ;
   }
   else if(text == '=')
   {
     return Colors.orange.shade400;
   }else if(text == '*' || text == '/' ||text == '-' || text == '+' || text == '%')
   {
     return Colors.lightBlue ;
   }
   else
   {
     return Colors.grey.shade300;
   }
 }
}
