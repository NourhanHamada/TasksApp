import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../constants/colors.dart';
import '../../controller/help_tasks.dart';
import 'home_screen.dart';

class DetailsScreen extends StatefulWidget {
  final id;
  final description;
  final title;
  final date;
  final done;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();

  DetailsScreen({
    required this.id,
    required this.description,
    required this.title,
    required this.date,
    required this.done,
  });
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  var _isClicked = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green2,
      appBar: AppBar(
        title: Text(
          'Details',
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
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              color: darkBeige.withOpacity(.2),
              borderRadius: BorderRadius.circular(20)),
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.title}',
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                      Text(
                        '${widget.date}',
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.description}',
                  style: TextStyle(color: darkBeige),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionBubble(
        iconData: _isClicked == true ? Icons.close : Icons.add,
        items: <Bubble>[
          Bubble(
            icon: Icons.delete,
            iconColor: red,
            title: 'Remove',
            titleStyle: const TextStyle(),
            bubbleColor: beige,
            onPress: () {
              _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward();

              setState(() {
                _isClicked = !_isClicked;
                HelpTasks()
                    .deleteDatabaseById(int.parse(widget.id))
                    .then((value) {
                  print('value ===> $value');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return HomeScreen();
                  }), (Route<dynamic> route) => false);
                });
              });
            },
          ),
          Bubble(
            icon: Icons.edit,
            iconColor: green,
            title: 'Edit',
            titleStyle: const TextStyle(),
            bubbleColor: beige,
            onPress: () {
              _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward();


              setState(() {
                _displayTextInputDialog(context, "${widget.description}");
                _isClicked = !_isClicked;
              });
            },
          ),
          Bubble(
            icon: Icons.share,
            iconColor: green,
            title: 'Share',
            titleStyle: const TextStyle(),
            bubbleColor: beige,
            onPress: () {
              _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward();

              setState(() {
                _isClicked = !_isClicked;
                Share.share("""Task App ✨️ ${widget.title} ${widget.date}
                                  
                                      ${widget.description}""");
              });
            },
          ),
        ],
        onPress: () {
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward();

          setState(() {
            _isClicked = !_isClicked;
          });
        },
        animation: _animation,
        iconColor: darkBeige,
        backGroundColor: green,
      ),
    );
  }

  String? valueText;
  TextEditingController descriptionController = TextEditingController();
  Future<void> _displayTextInputDialog(
      BuildContext context, String Description) async {
    descriptionController.text = Description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit description'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: descriptionController,
            ),
            actions: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: green,),
                onPressed: () {
                  setState(() {
                    HelpTasks()
                        .updateDatabaseById(descriptionController.text,
                            int.parse('${widget.id}'))
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  });
                },
                icon: Icon(Icons.done, color: darkBeige),
                label: Text(
                  "Done",
                  style: TextStyle(color: darkBeige),
                ),
              )
            ],
          );
        });
  }
}
