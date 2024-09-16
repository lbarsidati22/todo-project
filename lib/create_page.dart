import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  Map? itemData;
  CreatePage({super.key, this.itemData});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController descorationCon = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    final data = widget.itemData;
    if (widget.itemData != null) {
      isEdit = true;
      titleCon.text = data!['title'];
      descorationCon.text = data['description'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('task Title'),
              TextField(
                controller: titleCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('task descreption'),
              TextField(
                controller: descorationCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        onPressed: () {
                          isEdit ? updateData() : postData();
                        },
                        child: Text(isEdit ? 'update' : "Create"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //post
  Future<void> postData() async {
    final body = {
      "title": titleCon.text,
      "description": descorationCon.text,
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
  updateData() async {
    final id = widget.itemData!['_id'];
    final body = {
      "title": titleCon.text,
      "description": descorationCon.text,
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Oops samething is rong'),
        ),
      );
    }
  }
}
