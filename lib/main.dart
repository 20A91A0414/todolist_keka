import 'package:flutter/material.dart';
import 'package:todo_list/local_storage/todo_storage.dart';
import 'package:todo_list/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoStorage.initialize();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Todo List",
    home: HomePage(),
  ));
}

