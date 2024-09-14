import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_project/test/test_create.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contetx) => const TestCreate(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                color: Colors.black.withOpacity(.7),
              ),
            ),
            Text('Lbar sidati'),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    DateFormat.yMMMMEEEEd().format(
                      DateTime.now(),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
