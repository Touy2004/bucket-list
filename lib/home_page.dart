
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_page.dart';
import 'model.dart';

/// Home Page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Bucket> bucketList = []; // Full Buck

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bucket list")),
      body: bucketList.isEmpty
          ? const Center(child: Text("Please write a bucket list."))
          : ListView.builder(
              itemCount: bucketList.length, // Show as many bucketList items
              itemBuilder: (context, index) {
                Bucket bucket =
                    bucketList[index]; // Get the bucket corresponding to the index
                return ListTile(
                  // Bucket list to-do
                  title: Text(
                    bucket.job.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      color: bucket.isDone ? Colors.grey : Colors.black,
                      decoration: bucket.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ), // Delete icon button
                  trailing: IconButton(
                    icon: const Icon(CupertinoIcons.delete),
                    onPressed: () {
                      showDeleteDialog(context, index);
                      print('$bucket: Delete');
                    },
                  ),
                  onTap: () {
                    setState(() {
                      bucket.isDone = !bucket.isDone;
                    });

                    print('$bucket:clicked');
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Move to bucket

          String? job = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePage()),
          );
          if (job != null) {
            setState(() {
              Bucket newBucket = Bucket(job, false);
              bucketList.add(newBucket);
            });
          }
        },
      ),
    );
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure want to delete?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  bucketList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}