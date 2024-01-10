import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/cards/todo_item.dart';
import 'package:todo_list/local_storage/todo_storage.dart';
import 'package:todo_list/pages/add_todo_page.dart';
import 'package:todo_list/pages/task_page.dart';
import 'package:todo_list/utils/priority_enum.dart';
import 'package:todo_list/utils/task_status_enum.dart';

import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<TodoModel> list = [];

  @override
  void initState() {
    list = TodoStorage.toList(TodoStorage.getTodos());
    super.initState();
  }
  Future<void> _onRefresh() async {
    setState(() {
      list = TodoStorage.toList(TodoStorage.getTodos());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12, // newly added..

      // app bar..
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("TodoList", style: TextStyle(color: Colors.white),),
      ),

      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => TodoItem(model: list[index], onItemSelect: _onTodoTaskSelect,),
                  itemCount: list.length,
                ))
          ],
        ),
      ),

      // add todo button..
      floatingActionButton: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: _onAddItemClick,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))),
    );
  }

  void _onAddItemClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTodoPage(),));
  }

  _onTodoTaskSelect(TodoModel model) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(model: model),));
  }

}
