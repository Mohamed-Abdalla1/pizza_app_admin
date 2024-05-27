import 'package:flutter/material.dart';

class CreatePizza extends StatelessWidget {
  const CreatePizza({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
       
        height:MediaQuery.of(context).size.width ,
        color: Colors.orange,
      ),
    );
  }
}