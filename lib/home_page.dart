import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider.dart';
import 'package:todo_project/see_all.dart';
import 'package:todo_project/style_colors.dart';

import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<Service>(context, listen: false).fetchDataProvider();
    // fetchData();
    super.initState();
  }

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List myData = Provider.of<Service>(context).myData;
    return Scaffold(
      key: key,
      backgroundColor: kBlackColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDrangColor,
        onPressed: () {
          key.currentState!.showBottomSheet(
            (context) => CreatePage(),
          );
          // showBottomSheet(
          //     context: context,
          //     builder: (context) {
          //       return Container(
          //         height: 200,
          //         color: kDrangColor,
          //       );
          //     });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CreatePage(),
          //   ),
          // );
        },
        child: Icon(
          Icons.add,
          color: kWhightColor,
        ),
      ),
      appBar: AppBar(
        foregroundColor: kWhightColor,
        backgroundColor: kBlackColor,
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
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: kDrangColor,
                    ),
                    child: Text(
                      DateFormat.yMMMMEEEEd().format(
                        DateTime.now(),
                      ),
                      style: TextStyle(
                        color: kWhightColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: kBlack2Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(11),
                  ),
                  onPressed: () {
                    Provider.of<Service>(context, listen: false)
                        .fetchDataProvider();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: kWhightColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Text('Today task\s'),
              ],
            ),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contetx) => const SeeAll(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kBlack2Color,
                    ),
                    child: Text('See all'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
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
  //     final filterList = myData
  //         .where((element) => (DateFormat.yMMMEd()
  //                 .format(DateTime.parse(element['updated_at'])) ==
  //             DateFormat.yMMMEd().format(DateTime.now())))
  //         .toList();
  //     setState(() {
  //       // myData = json["items"];
  //       myData = filterList;
  //     });
  //     print(myData);
  //   }
  // }

  //chek
}
