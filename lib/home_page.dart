import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List myData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'Welcome back !',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Text(
              'lbar sidati',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
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
                IconButton(
                  onPressed: () {
                    fetchData();
                  },
                  icon: Icon(
                    Icons.refresh,
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: myData.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                          myData.reversed.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(
                            14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data['title'],
                                    style: TextStyle(
                                      decoration: data['is_completed']
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data['description'],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    DateFormat.yMMMEd().format(
                                      DateTime.parse(
                                        data['created_at'].toString(),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (contest) => CreatePage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                  ),
                                  Checkbox(
                                      value: data['is_completed'],
                                      onChanged: (value) {})
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(responce.body);
      setState(() {
        myData = json["items"];
      });
      print(myData);
    }
  }
}
