import 'package:todo_list/utils/methods.dart';
import 'package:todo_list/utils/task_status_enum.dart';

import '../utils/priority_enum.dart';

class TodoModel {
  String title;
  String description;
  String dueDate;
  String category;
  Priority priority;
  TaskStatus taskStatus;
  String refId;

  factory TodoModel.placeholder(){
    return TodoModel(title: "",
        description: "",
        dueDate: "",
        category: "",
        priority: Priority.low,
        taskStatus: TaskStatus.newTask,
        refId: "");
  }

  TodoModel({required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.priority,
    required this.taskStatus,
    required this.refId});

  // factory TodoModel.fromJson(Map<String, dynamic> json) {
  //   return TodoModel(
  //     title: json['title'],
  //     description: json['description'],
  //     dueDate: json['dueDate'],
  //     category: json['category'],
  //     priority: Methods.toPriorityEnum(json['priority']),
  //     taskStatus: Methods.toTaskEnum(json['status']),
  //     refId: json['refId']
  //   );
  // }


  toJson() =>
      {
        "title": title,
        "description": description,
        "dueDate": dueDate,
        "category": category,
        "priority": priority.name,
        "status": taskStatus.name,
        "refId": refId
      };


}
