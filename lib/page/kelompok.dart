import 'dart:io';
import 'package:flutter/material.dart';

class Kelompok extends StatefulWidget {
  const Kelompok({Key? key}) : super(key: key);

  @override
  State<Kelompok> createState() => _KelompokState();
}

class _KelompokState extends State<Kelompok> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Kelompok',
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
            children: [Text("124200068   Mario"), Text("124200077    Imam")]),
      ),
    );
  }
}
