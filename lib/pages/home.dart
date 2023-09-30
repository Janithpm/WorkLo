import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:worklo/constants/colors.dart';
import 'package:worklo/pages/signin.dart';
import 'package:worklo/widgets/todolist.dart';

import '../service/auth.dart';
import '../widgets/completedtodo.dart';

enum Priority { low, high }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth googleAuth = Auth();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  TimeOfDay _timeOfDay = TimeOfDay.now();

  final _categories = [
    "Work",
    "Meeting",
    "Travel",
    "Friend",
    "Family",
    "Workout",
    "Entertainment",
    "Other"
  ];
  final _priorities = [
    "High",
    "Medium",
    "Low",
  ];

  String _selectedCategory = "Work";
  String _selectedPriority = "Medium";

  Priority _priority = Priority.high;

  Future<void> saveTodo() async {
    String title = _titleController.text;
    String date = _dateController.text;
    String time = _timeController.text;
    String category = _selectedCategory;
    String priority = _selectedPriority;

    User? user = FirebaseAuth.instance.currentUser;

    try {
      await FirebaseFirestore.instance.collection("todos").add({
        "uid": user?.uid,
        "title": title,
        "isComplete": false,
        "date": date,
        "time": time,
        "category": category,
        "priority": priority,
        "createdAt": FieldValue.serverTimestamp(),
      });

      // reset controllers
      _titleController.clear();
      _dateController.clear();
      _timeController.clear();
      _selectedCategory = "Work";
      _selectedPriority = "Medium";

      const snakbar = SnackBar(content: Text("Task added successfully."));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    } catch (e) {
      const snakbar = SnackBar(content: Text("Something went wrong."));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await FirebaseFirestore.instance.collection('todos').doc(id).delete();
      const snakbar = SnackBar(content: Text("Task Deleted."));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    } catch (e) {
      const snakbar = SnackBar(content: Text("Something went wrong."));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    }
  }

  Future<void> markAsCompleted(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(id)
          .update({'isComplete': true});
      const snakbar = SnackBar(content: Text("Task Completed."));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    } catch (e) {
      const snakbar = SnackBar(content: Text("Something went wrong."));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: primaryColor,
          backgroundColor: primaryColor,
          title: const Text("WorkLo"),
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  await googleAuth.signoutWithGoogle();
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SigninPage()),
                      (route) => false);
                } catch (e) {
                  print(e);
                  final snakbar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snakbar);
                }
              },
              icon: const Icon(Icons.logout),
            )
          ],

          //tabbar
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.folder_special),
                text: "My Tasks",
              ),
              Tab(
                icon: Icon(Icons.rule_folder),
                text: "Completed Tasks",
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // openDialog();
            openModal();
          },
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [TodoList(), CompletedTodo()],
        ),
      ),
    );
  }

  Future openModal() async {
    await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext builder) {
          return Container(
            height: 500,
            color: CupertinoColors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add New Task",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ),
                  const SizedBox(height: 20),
                  //title
                  textInput("Task Name", _titleController),

                  const SizedBox(height: 5),
                  //priority and category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Priority",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            DropdownButton(
                              value: _selectedPriority,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(
                                height: 1,
                                color: Colors.black45,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPriority = newValue!;
                                });
                              },
                              items: _priorities
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            DropdownButton(
                              value: _selectedCategory,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(
                                height: 1,
                                width: 200,
                                color: Colors.black45,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCategory = newValue!;
                                });
                              },
                              items: _categories
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),
                  //date and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: datePicker(_dateController),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: timePicker(_timeController),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        saveTodo();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Add"),
                    ),
                  )
                ],
              ),
            ),
          );
        });

    // reset controllers
    _titleController.clear();
    _dateController.clear();
    _timeController.clear();
    _selectedCategory = "Work";
    _selectedPriority = "Medium";
  }

  Widget ChipData(String label) {
    return Chip(
      backgroundColor: Colors.black87,
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Add Task"),
            content: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  //task name
                  textInput("Task Name", _titleController),

                  //priority and category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Priority",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            DropdownButton(
                              value: _selectedPriority,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                color: Colors.black54,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPriority = newValue!;
                                });
                              },
                              items: _priorities
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            DropdownButton(
                              value: _selectedCategory,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                width: 200,
                                color: Colors.black54,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCategory = newValue!;
                                });
                              },
                              items: _categories
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  //date
                  const SizedBox(height: 10),
                  datePicker(_dateController),

                  //time
                  const SizedBox(height: 10),
                  timePicker(_timeController),

                  //description
                  // const SizedBox(height: 30),
                  // TextFormField(
                  //   minLines: 2,
                  //   maxLines: null,
                  //   // keyboardType: TextInputType.multiline,
                  //   controller: _descriptionController,
                  //   decoration: InputDecoration(
                  //     hintText: "Description",
                  //     hintStyle: TextStyle(color: Colors.black54),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: BorderSide(color: Colors.black),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: BorderSide(color: Colors.black),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: BorderSide(color: primaryColor),
                  //     ),
                  //   ),
                  //   style: TextStyle(color: Colors.black),
                  // ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  saveTodo();
                  Navigator.of(context).pop();
                },
                child: const Text("Add"),
              ),
            ],
          ));

  Widget textInput(String text, TextEditingController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(color: Colors.black54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black45),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black45),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget datePicker(TextEditingController controller) {
    return (TextField(
      controller: controller,
      //editing controller of this TextField
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Date" //label text of field
          ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            controller.text =
                formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    ));
  }

  Widget timePicker(TextEditingController controller) {
    return (TextField(
        controller: controller,
        decoration: const InputDecoration(
            icon: Icon(Icons.access_time), labelText: "Time"),
        readOnly: true,
        onTap: () {
          selectTime(controller);
        }));
  }

  Future<void> selectTime(TextEditingController controller) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: _timeOfDay);
    if (pickedTime != null) {
      setState(() {
        _timeOfDay = pickedTime;
        controller.text = _timeOfDay.format(context);
      });
    }
  }
}
