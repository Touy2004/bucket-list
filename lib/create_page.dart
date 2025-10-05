import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Bucket creation page
class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController textController = TextEditingController();
  String? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a bucket list"), // Back
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Text input window
            TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Enter what you want to do",
              ),
            ),
            const SizedBox(height: 32), // Add

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: const Text("Add", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  // When the Add
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      error =
                          "Please enter some content."; // Error message if there is no content
                    });
                  } else {
                    setState(() {
                      error = null; // Hide error message if there is content
                    });
                    Navigator.pop(context, job); // Close the screen.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
