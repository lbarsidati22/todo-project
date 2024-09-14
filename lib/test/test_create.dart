import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestCreate extends StatefulWidget {
  const TestCreate({super.key});

  @override
  State<TestCreate> createState() => _TestCreateState();
}

class _TestCreateState extends State<TestCreate> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descrritController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TaskTitle'),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  17,
                )),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text('TaskDescorit'),
            TextField(
              controller: descrritController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  17,
                )),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  postData();
                },
                child: Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> postData() async {
    final body = {
      "title": "string",
      "description": "string",
      "is_completed": false
    };
    var url = Uri.parse('https://api.nstack.in/v1/todos');
    var responce = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    if (responce.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Created'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Opps something is rong'),
        ),
      );
    }
  }
}
