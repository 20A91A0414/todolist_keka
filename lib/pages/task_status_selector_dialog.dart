import 'package:flutter/material.dart';
import 'package:todo_list/utils/task_status_enum.dart';

class TaskStatusSelectorDialog extends StatelessWidget {
  final Function(TaskStatus) onChange;

  const TaskStatusSelectorDialog({Key? key, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () => onChange(TaskStatus.progress),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.circle_outlined),
                    SizedBox(width: 8,),
                    Text("In Progress"),
                  ],
                ),
              )),
          InkWell(
              onTap: () => onChange(TaskStatus.completed),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.circle_outlined),
                    SizedBox(width: 8,),
                    Text("Completed"),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
