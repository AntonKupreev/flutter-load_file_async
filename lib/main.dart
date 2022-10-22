import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:load_file_async/fetch_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load file'),
      ),
      body: const MainScrean(),
    );
  }
}

class MainScrean extends StatefulWidget {
  const MainScrean({super.key});

  @override
  State<MainScrean> createState() => _MainScreanState();
}

class _MainScreanState extends State<MainScrean> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.all(15.0),
              //padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: Colors.black, width: 2),
              ),
              height: 50,
              width: 400,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        height: 43,
                        width: 230,
                        child: TextFormField(
                          controller: _nameController,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: _submitForm,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        height: 50,
                        child: const Center(
                          child: Text(
                            'найти',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<String>(
                future: fetchFileFromAssets2('assets/${_nameController.text}'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: Text('NONE'),
                      );
                      break;

                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      return SingleChildScrollView(
                        child: Center(
                          child: Text(snapshot.data),
                        ),
                      );

                    default:
                      return SingleChildScrollView(
                        child: Text(snapshot.data),
                      );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitForm() {
    if (_nameController.text.isEmpty) {
      return;
    }
    setState(() {});
    Text('file: ${_nameController.text}');
  }
}
