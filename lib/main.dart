
import 'package:flutter/material.dart';
import 'package:quotify/screens/quote.dart';


final kcolorSheme = const Color.fromARGB(225,44 ,62 ,80);

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({
    super.key
});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: kcolorSheme),
        scaffoldBackgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),

      home:const  QuoteScreen(),
    );

  }
}