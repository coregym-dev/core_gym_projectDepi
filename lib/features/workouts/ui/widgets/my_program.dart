import 'package:flutter/material.dart';

class MyProgram extends StatefulWidget {
  const MyProgram({super.key});

  @override
  State<MyProgram> createState() => _MyProgramState();
}

class _MyProgramState extends State<MyProgram> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Create Your Program",
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }
}
