import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/home_page.dart';
import 'package:todo_project/provider.dart';
import 'package:todo_project/style_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Service();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const HomePage(),
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: kWhightColor,
              ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
