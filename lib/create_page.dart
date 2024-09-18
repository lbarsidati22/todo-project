import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:todo_project/provider.dart';

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
                          isEdit
                              ? Provider.of<Service>(context, listen: false)
                                  .updateData(
                                      id1: widget.itemData!['_id'],
                                      title: titleCon.text,
                                      desc: descorationCon.text,
                                      context: context)
                              : Provider.of<Service>(context, listen: false)
                                  .postData(
                                      title: titleCon.text,
                                      desc: descorationCon.text,
                                      context: context);
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
}
