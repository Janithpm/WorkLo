import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:worklo/constants/colors.dart';
import 'package:worklo/pages/signin.dart';

import '../service/auth.dart';

class CompletedTodo extends StatefulWidget {
  const CompletedTodo({Key? key}) : super(key: key);

  @override
  State<CompletedTodo> createState() => _CompletedTodoState();
}

class _CompletedTodoState extends State<CompletedTodo> {
  Auth googleAuth = Auth();

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

  Future<void> markAsUnCompleted(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(id)
          .update({'isComplete': false});
      const snakbar = SnackBar(content: Text("Task Re-added."));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    } catch (e) {
      const snakbar = SnackBar(content: Text("Something went wrong."));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('todos')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .where('isComplete', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;

        if (querySnapshot.docs.isEmpty) {
          return Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "No Completed Tasks",
                  style: TextStyle(fontSize: 23, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.rule_folder_outlined,
                  size: 70,
                  color: Colors.black45,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add new tasks by",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "pressing + button.",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView(
              children: querySnapshot.docs.map((doc) {
                return TodoCard(
                  doc.id,
                  doc['title'],
                  doc['date'],
                  doc['time'],
                  doc['priority'],
                  doc['category'],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget TodoCard(String id, String title, String date, String time,
      String priority, String category) {
    return InkWell(
      onLongPress: () {
        openDeleteModel(id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 0.5, color: Colors.black38),
        ),
        // color: Colors.black54,
        elevation: 0,
        child: Container(
          // height: 140,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    // letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ChipData(priority.toString()),
                        const SizedBox(width: 10),
                        ChipData(category),
                      ],
                    ),
                    IconButton(
                      tooltip: "Mark as ucompleted",
                      splashRadius: 20.0,
                      onPressed: () {
                        markAsUnCompleted(id);
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                        semanticLabel: "Check",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  Future openDeleteModel(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Do you want to delete this task? "),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No, Cancel"),
            ),
            TextButton(
              onPressed: () {
                deleteTodo(id);
                Navigator.of(context).pop();
              },
              child: const Text("Yes, Delete"),
            ),
          ],
        ),
      );
}
