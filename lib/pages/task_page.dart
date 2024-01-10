import 'package:flutter/material.dart';
import 'package:todo_list/cards/todo_item.dart';
import 'package:todo_list/local_storage/todo_storage.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/pages/task_status_selector_dialog.dart';
import 'package:todo_list/utils/methods.dart';
import 'package:todo_list/utils/task_status_enum.dart';

class TaskPage extends StatefulWidget {
  final TodoModel model;
  const TaskPage({Key? key, required this.model}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  late DateTime date;
  late int days;
  List<TodoModel> categoriesList = [];

  @override
  void initState() {
    date = DateTime.parse(widget.model.dueDate);
    days = Methods.getDays(widget.model.dueDate);
    _getCategoriesFromList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // app bar..
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Task Details",
          style: TextStyle(color: Colors.white),
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // due date..
                  Text("Due Date: ${date.day}-${date.month}-${date.year}"),

                  // days..
                  if(days>0)Text("$days days Left", style: const TextStyle(color: Colors.black26, fontSize: 10),)
                ],
              ),
              const SizedBox(height: 26,),

              // title..
              Text(widget.model.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),),

              // description..
              Text(
                widget.model.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 36,),

              // priority..
              Text("Priority ${widget.model.priority.name}"),


              // status..
              Text("Status: ${widget.model.taskStatus.name}"),
              const SizedBox(height: 36,),

              // delete and change progress..
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: _onRemoveTaskClick, icon: const Icon(Icons.delete_rounded, color: Colors.black87,)),
                  ElevatedButton(onPressed: _changeStatus, child: const Text("Change Status"))
                ],
              ),
              const SizedBox(height: 50,),

              if(categoriesList.isNotEmpty)  const Text("Category"),
              if(categoriesList.isNotEmpty) SizedBox(height: 180, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: categoriesList.length, itemBuilder: (context, index) => TodoItem(model: categoriesList[index], maxWidth: 300, onItemSelect: _onTaskSelect),))

            ],
          ),
        ),
      ),
    );
  }

  void _onRemoveTaskClick() {
    TodoStorage.remove(widget.model);
    Navigator.pop(context);
  }

  void _changeStatus() {
    showDialog(context: context, builder: (context) => TaskStatusSelectorDialog(onChange: (status){
      Navigator.pop(context);
      if(TodoStorage.updateProgress(widget.model, status)){
        setState(() {
          widget.model.taskStatus = status;
        });
      }
    }),);
  }

  _onTaskSelect(TodoModel model) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(model: model),));
  }

  void _getCategoriesFromList() {
    List<TodoModel> list = TodoStorage.toList(TodoStorage.getTodos());
    for(int i=0; i<list.length; i++){
      if(list[i].category == widget.model.category && list[i].refId != widget.model.refId){
        categoriesList.add(list[i]);
      }
    }
    setState(() {
    });
  }
}
