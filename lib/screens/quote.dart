

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class QuoteScreen extends StatefulWidget{
  
  const QuoteScreen({
    super.key
});
  
 @override
  State<QuoteScreen> createState() {
    
   return _QuoteScreenState();
    
  }
}

class _QuoteScreenState extends State<QuoteScreen>{

  final tealColor = const Color.fromARGB(225,26, 188 ,156);
  final actioColor =const Color.fromARGB(225,231 ,75 ,60);
  final primaryColor =const Color.fromARGB(225,44 ,62 ,80);
  final textColor =const Color.fromARGB(225,12, 16 ,21);
  final url = Uri.parse('https://quotes-api-self.vercel.app/quote');
  var fetchedQuote = '';
  var isQuoteEmpty = true;
  

  

  void _fetchQuote() async{
    
    try{
      final response = await http.get(url);
      
      if(response.statusCode >=400){
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch data Please try again later'),
            ),
            );

      }

      if(response.body=='null'){
        return;
      }

      if(response.statusCode ==200){
        final data = json.decode(response.body);
        setState(() {
          isQuoteEmpty = false;
          fetchedQuote = data['quote'];
        });
        
      }

      

  } catch(error){
    
    print(error.toString());
    
    ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            ),
            );
  }
  }

  
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('QuotiFY',style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 15,
              shadowColor: Theme.of(context).colorScheme.primary,
              child: Container(
                padding: EdgeInsets.all(20),
                
                height: min(350, 500),
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [tealColor,Colors.white], begin: Alignment.topLeft),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2,color: primaryColor)
                ),
                child: Center(
                  child: Text(isQuoteEmpty?  "Start To fetch Your Quote" :fetchedQuote,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: textColor
                  ),
                  textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(225,231 ,75 ,60)
              ),
              onPressed: (){
                _fetchQuote();
              },
              child: Text("Fetch Quote",
              style: TextStyle(
                color: textColor,
                fontSize: 17
                
              ),
              ))
          ]
          
        ),
      ),
      ),
    )
    ;
  }
  
}