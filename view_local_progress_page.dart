import 'package:flutter/material.dart';
import 'package:newproject/helpers/database_helper.dart';

class ViewLocalProgressPage extends StatefulWidget {
  const ViewLocalProgressPage({super.key});

  @override
  State<ViewLocalProgressPage> createState() => _ViewLocalProgressPageState();
}

class _ViewLocalProgressPageState extends State<ViewLocalProgressPage> {
  List<Map<String, dynamic>> _progressList = [];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final data = await DatabaseHelper().getProgress();
    setState(() {
      _progressList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Progress Tracker"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _progressList.isEmpty
          ? const Center(child: Text("No progress data saved."))
          : ListView.builder(
        itemCount: _progressList.length,
        itemBuilder: (context, index) {
          final item = _progressList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ListTile(
              title: Text("${item['exercise']} (${item['duration']} min)"),
              subtitle: Text("Trainer: ${item['trainer']}  •  ${item['date']}"),
            ),
          );
        },
      ),
    );
  }
}
