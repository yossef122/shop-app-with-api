import 'package:flutter/material.dart';


var current_Index =0;

var current_Index1 = 0;

Color defaultcolor=Colors.blue;

List<BottomNavigationBarItem> navbar=[
  BottomNavigationBarItem(icon: Icon(Icons.business_sharp),label: "Business"),
  BottomNavigationBarItem(icon: Icon(Icons.sports),label: "Sports"),
  BottomNavigationBarItem(icon: Icon(Icons.science_outlined),label:"Science"),
  // BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Setting"),
];

List<Widget> screens=[

];

  bool IsSearch =true ;

  bool ispass=true;
  IconData suffix=Icons.visibility_outlined;

  String? token ='';