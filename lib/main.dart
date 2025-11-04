import 'package:flutter/material.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key});
  
  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  final List<String> _array = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, i) {
      print('num $i : нечетное = ${i.isOdd}');

      if (i.isOdd) return const Divider();

      final index = i ~/ 2;

      print('index $index');
      print('length ${_array.length}');

      if (index >= _array.length) {
        _array.addAll(['$index', '${index + 1}', '${index + 2}']);
      }

      return ListTile(
        title: Text(_array[index]),
      );
    },);
  }
}

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('App')),
        body: Center(
          child: MyBody()
          )
      ),
    );
  }
}
