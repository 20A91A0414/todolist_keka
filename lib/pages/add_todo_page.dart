import 'package:flutter/material.dart';
import 'package:todo_list/local_storage/todo_storage.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/utils/task_status_enum.dart';

import '../utils/priority_enum.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? dueDate;
  Priority? _priorityValue;

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
          "Add Todo",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // title..
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: "Title"),
              ),

              // category..
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(hintText: "Category"),
              ),

              // description..
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: 10,
                decoration: const InputDecoration(hintText: "Description"),
              ),
              const SizedBox(
                height: 12,
              ),

              // calender..
              InkWell(
                onTap: _onCalenderClick,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded),
                      SizedBox(
                        width: 26,
                      ),
                      Text("Select DueDate"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              // priority group of radios..
              const Text(
                "Priority",
                style: TextStyle(color: Colors.black),
              ),
              _myRadioButton(
                  title: "Low",
                  value: Priority.low,
                  onChanged: (newValue) {
                    setState(() {
                      _priorityValue = newValue;
                    });
                  }),
              _myRadioButton(
                  title: "Medium",
                  value: Priority.medium,
                  onChanged: (newValue) {
                    setState(() {
                      _priorityValue = newValue;
                    });
                  }),
              _myRadioButton(
                  title: "High",
                  value: Priority.high,
                  onChanged: (newValue) {
                    setState(() {
                      _priorityValue = newValue;
                    });
                  }),
              const SizedBox(
                height: 12,
              ),

              // bottom buttons (draft, save) ..
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: _onSaveClick, child: const Text("Save"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myRadioButton(
      {required String title,
      required Priority value,
      required Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _priorityValue,
      onChanged: (value) => onChanged(value),
      title: Text(title),
    );
  }

  void _onSaveClick() {
    TodoStorage.addTodo(TodoModel(
        title: _titleController.text.toString().trim(),
        description: _descriptionController.text.toString().trim(),
        dueDate:
            (dueDate == null) ? DateTime.now().toString() : dueDate.toString(),
        category: _categoryController.text.toString().trim(),
        priority: _priorityValue ?? Priority.low,
        taskStatus: TaskStatus.newTask,
        refId: DateTime.now().toString()));
    Navigator.pop(context);
  }

  void _onCalenderClick() async {
    dueDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2024, 1),
        lastDate: DateTime(2101));
  }
}
