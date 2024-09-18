import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:todo_project/provider.dart';

import 'create_page.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  void initState() {
    // fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List myData = Provider.of<Service>(context).allList;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<Service>(context, listen: false).fetchDataProvider();
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'All Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
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
                                          builder: (contest) => CreatePage(
                                            itemData: data,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              icon: Icon(
                                                Icons.wrong_location,
                                              ),
                                              title: Text('Alertt'),
                                              shadowColor: Colors.black,
                                              elevation: 40,
                                              content: Text(
                                                'are you sure ?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Provider.of<Service>(
                                                            context,
                                                            listen: false)
                                                        .deleteById(
                                                            data["_id"]);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Yes'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('No'),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                  Checkbox(
                                      value: data['is_completed'],
                                      onChanged: (value) {
                                        Provider.of<Service>(context,
                                                listen: false)
                                            .check(
                                          check: value!,
                                          id2: data["_id"],
                                          title: data['title'],
                                          desc: data['description'],
                                        );
                                      })
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

  // Future<void> fetchData() async {
  //   var url = Uri.parse("https://api.nstack.in/v1/todos");
  //   var responce = await http.get(url);
  //   if (responce.statusCode == 200) {
  //     Map<String, dynamic> json = jsonDecode(responce.body);
  //     myData = json["items"];
  //     // final filterList = myData
  //     //     .where((element) => (DateFormat.yMMMEd()
  //     //             .format(DateTime.parse(element['updated_at'])) ==
  //     //         DateFormat.yMMMEd().format(DateTime.now())))
  //     //     .toList();
  //     setState(() {
  //       myData = json["items"];
  //       // myData = filterList;
  //     });
  //     print(myData);
  //   }
  // }

  //chek
  // check(
  //   bool check,
  //   int index,
  //   String title,
  //   String desc,
  // ) async {
  //   final id = myData[index]['_id'];
  //   final body = {
  //     "title": title,
  //     "description": desc,
  //     "is_completed": check,
  //   };
  //   var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
  //   final responce = await http.put(
  //     url,
  //     body: jsonEncode(body),
  //     headers: {"Content-Type": "application/json"},
  //   );
  //   print(responce.statusCode);
  //   fetchData();
  // }

  //delete
}
