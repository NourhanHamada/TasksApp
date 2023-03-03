import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/controller/help_tasks.dart';
import 'package:todo_app/view/screens/add_task_screen.dart';
import 'package:todo_app/view/screens/details_screen.dart';
import 'package:todo_app/view/screens/empty_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HelpTasks().db.then((value) {
      print("value ====>  $value");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green2,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: HelpTasks().getDB(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return (snapshot.data.length == 0)
                  ? Center(
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
              )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (value) {
                                  setState(() {
                                    HelpTasks().deleteDatabaseById(
                                        snapshot.data[index].id);
                                  });
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: red,
                                icon: Icons.delete,
                              ),
                              SlidableAction(
                                onPressed: (value) {
                                  setState(() {
                                    Share.share(
                                        """Task App ✨️ ${snapshot.data[index].title} ${snapshot.data[index].date}
                                  
                                      ${snapshot.data[index].description}""");
                                  });
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: darkBeige,
                                icon: Icons.share,
                              ),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 3,
                            color: beige,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                    return  DetailsScreen(
                                      id: '${snapshot.data[index].id}',
                                      description: '${snapshot.data[index].description}',
                                      title: '${snapshot.data[index].title}',
                                      date: '${snapshot.data[index].date}',
                                      done: '${snapshot.data[index].done}',
                                    );
                                  }));
                                },
                                title: Text(
                                  '${snapshot.data[index].title}',
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                                subtitle: Text(
                                  '${snapshot.data[index].description}',
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                                trailing: Text(
                                  '${snapshot.data[index].date}',
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return CircularProgressIndicator(
                backgroundColor: darkBeige,
                valueColor: AlwaysStoppedAnimation(green),
              );
            }
          },
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
