import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/controller/help_tasks.dart';
import 'package:todo_app/view/screens/home_screen.dart';
import '../../constants/colors.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var dateTime;
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green2,
      appBar: AppBar(
        title: Text(
          'New Task',
          style: TextStyle(
            color: darkBeige,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  labelText: 'Title',
                  labelStyle: TextStyle(color: darkBeige, fontSize: 16),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: green)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: darkBeige,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () {
                  setState(() {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                      maxTime: DateTime(2030, 1, 1),
                      minTime: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      onChanged: (data) {
                        setState(() {
                          dateTime = '${data.year}/ ${data.month}/ ${data.day}';
                          dateController.text = dateTime;
                        });
                      },
                      onConfirm: (data) {
                        setState(() {
                          dateTime = '${data.year}/ ${data.month}/ ${data.day}';
                          dateController.text = dateTime;
                        });
                      },
                    );
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                decoration: InputDecoration(
                  hintText: 'Enter date',
                  labelText: 'Date',
                  labelStyle: TextStyle(color: darkBeige, fontSize: 16),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: green)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: darkBeige,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  labelText: 'Description',
                  labelStyle: TextStyle(color: darkBeige, fontSize: 16),
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: green)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: darkBeige,
                    ),
                  ),
                ),
                maxLines: 8,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: green),
                onPressed: () {
                  HelpTasks().insertDB({
                    'description': descriptionController.text.toString(),
                    'title': titleController.text.toString(),
                    'date': dateController.text.toString(),
                    'done': '0',
                  }).then((value) {
                    print('value ===> $value');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return HomeScreen();
                        }), (Route<dynamic> route) => false);
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
