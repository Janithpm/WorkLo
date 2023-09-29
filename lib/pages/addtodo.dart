import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worklo/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:worklo/pages/signin.dart';
import 'package:worklo/service/auth.dart';

enum Priority { low, high }

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  TimeOfDay _timeOfDay = TimeOfDay.now();

  Auth googleAuth = Auth();

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
    String description = _descriptionController.text;
    String date = _dateController.text;
    String time = _timeController.text;
    String category = _selectedCategory;
    String priority = _selectedPriority;

    // save on firestore

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: primaryColor,
          backgroundColor: primaryColor,
          title: Text("WorkLo"),
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
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(CupertinoIcons.arrow_left),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Create New Task",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      //title
                      TextInput("Task Name", _titleController),
                      const SizedBox(
                        height: 10,
                      ),

                      // priority and category
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
                                const SizedBox(
                                  height: 10,
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
                                const SizedBox(
                                  height: 10,
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
                      const SizedBox(
                        height: 30,
                      ),

                      // date
                      DatePircker(_dateController),
                      const SizedBox(
                        height: 30,
                      ),

                      //time
                      TimePicker(_timeController),
                      const SizedBox(
                        height: 30,
                      ),

                      // description
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        // height: 150,
                        child: TextFormField(
                          minLines: 2,
                          maxLines: null,
                          // keyboardType: TextInputType.multiline,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      //button
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            saveTodo();
                          },
                          child: const Text(
                            "Create Task",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget TextInput(String text, TextEditingController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(color: Colors.black54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget DatePircker(TextEditingController controller) {
    return (TextField(
      controller: controller,
      //editing controller of this TextField
      decoration: InputDecoration(
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
            _dateController.text =
                formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    ));
  }

  Widget RadioBtnGroup() {
    return Container(
      child: Column(
        children: [
          Text("Priority of the task"),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                  child: RadioListTile(
                      title: Text("High",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      dense: true,
                      value: Priority.high,
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value as Priority;
                        });
                      })),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: RadioListTile(
                      title: Text("Low",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      tileColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      dense: true,
                      value: Priority.low,
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value as Priority;
                        });
                      }))
            ],
          ),
        ],
      ),
    );
  }

  Widget ChipData(String label) {
    return Chip(
      backgroundColor: Colors.black87,
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    );
  }

  Widget TimePicker(TextEditingController controller) {
    return (TextField(
        controller: controller,
        //editing controller of this TextField
        decoration: const InputDecoration(
            icon: Icon(Icons.access_time), //icon of text field
            labelText: "Time" //label text of field
            ),
        readOnly: true,
        onTap: () {
          selectTime();
        }));
  }

  Future<void> selectTime() async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: _timeOfDay);
    if (pickedTime != null) {
      setState(() {
        _timeOfDay = pickedTime;
        _timeController.text = _timeOfDay.format(context);
      });
    }
  }
}
