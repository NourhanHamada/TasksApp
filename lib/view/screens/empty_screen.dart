import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'add_task_screen.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green2,
      appBar: AppBar(
        title: Text(
          'ToDo',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(
              flex: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/images/noFiles.png'), width: 100,),
                20.ph,
                Text(
                  "Don't have any tasks yet! 😌",
                  style: TextStyle(
                    color: darkBeige,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                7.ph,
                Text(
                  "Add your first one ✨",
                  style: TextStyle(
                    color: green,
                    fontSize: 18,
                    fontWeight: FontWeight.w200
                  ),
                ),
              ],
            ),
            30.ph,
            Image(image: const AssetImage('assets/icons/snakeArrow.png',), color: darkBeige,width: 100,),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return const AddTaskScreen();
            }),
          );
        },
        elevation: 5,
        backgroundColor: green,
        child: Icon(
          Icons.add,
          color: darkBeige,
          size: 30,
        ),
      ),
    );
  }
}


extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble(),);
  SizedBox get pw => SizedBox(width: toDouble(),);
}
