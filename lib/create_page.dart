import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider.dart';
import 'package:todo_project/style_colors.dart';

// ignore: must_be_immutable
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
    return Container(
      decoration: BoxDecoration(
        color: kBlackColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('task Title'),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: titleCon,
                decoration: InputDecoration(
                  hintText: 'tap title here...',
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
              SizedBox(
                height: 11,
              ),
              TextField(
                maxLines: 5,
                controller: descorationCon,
                decoration: InputDecoration(
                  hintText: 'tap descreption here...',
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
                          backgroundColor: kDrangColor,
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
                        child: Text(
                          isEdit ? 'update' : "Create",
                          style: TextStyle(
                            color: kWhightColor,
                          ),
                        ),
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
