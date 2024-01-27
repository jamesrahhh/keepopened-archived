import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

enum Statuses { running, executing, stopped, invalid }

void main() {
  runApp(const Keepopened());
}

class Keepopened extends StatelessWidget {
  const Keepopened({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String name = 'none';

  Statuses status = Statuses.invalid;

  Future<void> _incrementCounter() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        name = basename(file.path);
        if (name.contains('.exe')) {
          status = Statuses.stopped;
        } else {
          status = Statuses.invalid;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: _incrementCounter, child: const Icon(Icons.settings)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected file: $name'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Status: ${status.name}'),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: _incrementCounter,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Add file',
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 20.0,
                      grade: 100.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
