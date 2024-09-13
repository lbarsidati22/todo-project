import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Column(
          children: [
            Text(
              'Welcome back !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            Text(
              'lbar sidati',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Text(
                  DateFormat.yMMMMEEEEd().format(
                    DateTime.now(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
