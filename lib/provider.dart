import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Service with ChangeNotifier {
  List myData = [];
  List allList = [];
  //get
  fetchDataProvider() async {
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var responce = await http.get(url);
    if (responce.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(responce.body);
      myData = json["items"];
      final filterList = myData
          .where((element) => (DateFormat.yMMMEd()
                  .format(DateTime.parse(element['updated_at'])) ==
              DateFormat.yMMMEd().format(DateTime.now())))
          .toList();

      myData = filterList;

      allList = json["items"];

      notifyListeners();
      print(myData);
    }
  }

//check
  check({
    required bool check,
    required String id2,
    required String title,
    required String desc,
  }) async {
    final id = id2;
    final body = {
      "title": title,
      "description": desc,
      "is_completed": check,
    };
    var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    final responce = await http.put(
      url,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    notifyListeners();
    print(responce.statusCode);
  }

//post
  postData(
      {required String title,
      required String desc,
      required BuildContext context}) async {
    final body = {
      "title": title,
      "description": desc,
      "is_completed": false,
    };
    var url = Uri.parse("https://api.nstack.in/v1/todos");
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
      Navigator.pop(context);
      fetchDataProvider();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Oops samething is rong'),
        ),
      );
    }
  }

  //update
  updateData({
    required String id1,
    required String title,
    required String desc,
    required BuildContext context,
  }) async {
    final id = id1;
    final body = {
      "title": title,
      "description": desc,
      "is_completed": false,
    };
    var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    final responce = await http.put(
      url,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    if (responce.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Updated'),
        ),
      );
      Navigator.pop(context);
      fetchDataProvider();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Oops samething is rong'),
        ),
      );
    }
  }
  //delete

  deleteById(String id) async {
    var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    await http.delete(url);
    // fetchData();
  }
}
