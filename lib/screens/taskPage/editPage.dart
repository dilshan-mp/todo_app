import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String taskText;
  final DateTime createdAt;
  final String categoryColor;
  final String icon;
  final String category;
  final dynamic priority;
  const EditPage({
    super.key,
    required this.taskText,
    required this.createdAt,
    required this.categoryColor,
    required this.icon,
    required this.category,
    required this.priority,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            //color: Colors.amber,
            width: double.infinity,
            height: 80,
            child: ListTile(
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
                shape: CircleBorder(),
              ),
              title: Text(
                widget.taskText,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              subtitle: Text(
                '${widget.createdAt.hour}:${widget.createdAt.minute} ${widget.createdAt.day}/${widget.createdAt.month}/${widget.createdAt.year}',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              trailing: const Icon(Icons.edit),
            ),
          ),
          Container(
            //color: Colors.amber,
            width: double.infinity,
            height: 60,
            child: ListTile(
              leading: Icon(Icons.timer),
              title: const Text(
                'Task Time',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              trailing: Container(
                color: Colors.black,
                width: 70,
                height: 40,
                child: Text(
                  '${widget.createdAt.hour}:${widget.createdAt.minute} ${widget.createdAt.day}/${widget.createdAt.month}/${widget.createdAt.year}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            //color: Colors.amber,
            width: double.infinity,
            height: 60,
            child: ListTile(
              leading: Icon(Icons.tag),
              title: const Text(
                "Task Category",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              trailing: Container(
                width: 80, // Optional padding for some spacing
                height: 40,
                decoration: BoxDecoration(
                  color: widget.categoryColor.isNotEmpty
                      ? Color(int.parse(
                          widget.categoryColor.replaceFirst('#', '0XFF')))
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      //color: Colors.amber,
                      width: 20,
                      height: 20,
                      child: widget.icon.isNotEmpty
                          ? Image.asset(
                              widget.icon,
                              fit: BoxFit.fill,
                            )
                          : const Icon(Icons.category),
                    ),
                    Container(
                      //color: Colors.white,
                      width: 60,
                      child: Center(child: Text(widget.category)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            //color: Colors.amber,
            width: double.infinity,
            height: 60,
            child: ListTile(
                leading: Icon(Icons.flag_outlined),
                title: const Text(
                  'Priority',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  height: 40,
                  width: 40,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          widget.priority,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          Container(
            //color: Colors.amber,
            width: double.infinity,
            height: 60,
            child: ListTile(
                leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                title: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    //color: Colors.amber,
                    width: 20,
                    height: 20,
                    child: const Text(
                      "Delete Task",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
