import 'package:fcmpoc/components/second/second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondView extends State<Second> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Text(
            "Message Page",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
