import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:todo_project/provider.dart';
import 'package:todo_project/style_colors.dart';

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

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List myData = Provider.of<Service>(context).allList;
    return Scaffold(
      backgroundColor: kBlackColor,
      key: key,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDrangColor,
        onPressed: () {
          key.currentState!.showBottomSheet(
            (context) => CreatePage(),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        excludeHeaderSemantics: false,
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: kGreyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            onPressed: () {
              Provider.of<Service>(context, listen: false).fetchDataProvider();
            },
            icon: Icon(
              color: kWhightColor,
              Icons.refresh,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'All Tasks',
          style: TextStyle(
            color: kWhightColor,
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
                            color: kBlack2Color,
                            borderRadius: BorderRadius.circular(12),
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
                                      style: TextStyle(
                                        color: kGreyColor,
                                      ),
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
                                    style: TextStyle(
                                      color: kGreyColor,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      key.currentState!.showBottomSheet(
                                          (context) => CreatePage(
                                                itemData: data,
                                              ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: kGreenColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: kBlack2Color,
                                              icon: Icon(
                                                Icons.warning,
                                                color: kRedColor,
                                                size: 35,
                                              ),
                                              title: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text('Alertt'),
                                              ),
                                              shadowColor: Colors.black,
                                              elevation: 40,
                                              content: Text(
                                                'are you sure ?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: kRedColor,
                                                  ),
                                                  onPressed: () {
                                                    Provider.of<Service>(
                                                            context)
                                                        .deleteById(
                                                      data["_id"],
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: kWhightColor),
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: kGreyColor,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('No',
                                                      style: TextStyle(
                                                          color: kWhightColor)),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: kRedColor,
                                    ),
                                  ),
                                  Checkbox(
                                      side: BorderSide(
                                        color: kWhightColor,
                                      ),
                                      shape: CircleBorder(
                                          side: BorderSide(
                                        color: kWhightColor,
                                      )),
                                      value: data['is_completed'],
                                      onChanged: (value) {
                                        Provider.of<Service>(context).check(
                                          check: value!,
                                          title: data['title'],
                                          id2: data['_id'],
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
