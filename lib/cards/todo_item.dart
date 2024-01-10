import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/utils/methods.dart';
import 'package:todo_list/utils/my_color.dart';
import 'package:todo_list/utils/task_status_enum.dart';

class TodoItem extends StatelessWidget {
  final TodoModel model;
  final Function(TodoModel) onItemSelect;
  final double? maxWidth;
  const TodoItem({Key? key, required this.model, required this.onItemSelect, this.maxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int days = Methods.getDays(model.dueDate);
    final DateTime date = DateTime.parse(model.dueDate);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8.0),
      child: InkWell(
        onTap: ()=>onItemSelect(model),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth??double.infinity
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // title and days..
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                    if(days>0)Text("${days} days Left", style: const TextStyle(color: Colors.black26, fontSize: 10),)
                  ],
                ),

                // category..
                Text(
                  model.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 12),
                ),

                // description..
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    model.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),


                // due date..
                Text("Due Date: ${date.day}-${date.month}-${date.year}"),

                // priority and status..
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Priority: ${model.priority.name}"),
                    TaskStatusView(status: model.taskStatus)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskStatusView extends StatelessWidget {
  final TaskStatus status;

  const TaskStatusView({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == TaskStatus.newTask) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: MyColors.red12),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            "New",
            style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    if (status == TaskStatus.progress) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: MyColors.blue12),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            "InProgress",
            style: TextStyle(color: MyColors.blue, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    if (status == TaskStatus.completed) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: MyColors.green12),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            "Completed",
            style: TextStyle(color: MyColors.green, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    return const Text(
      "Draft",
      style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}
