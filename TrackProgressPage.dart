import 'package:flutter/material.dart';
import 'package:newproject/helpers/database_helper.dart';

class TrackProgressPage extends StatefulWidget {
  final Map<String, dynamic> trainer;
  const TrackProgressPage({Key? key, required this.trainer}) : super(key: key);

  @override
  State<TrackProgressPage> createState() => _TrackProgressPageState();
}

class _TrackProgressPageState extends State<TrackProgressPage> {
  late List<String> exercises;
  late Map<String, String> beforeProgress;
  late Map<String, String> afterProgress;
  late String beforeDate;
  late String afterDate;

  @override
  void initState() {
    super.initState();
    beforeProgress = widget.trainer['beforeProgress'] as Map<String, String>? ?? {};
    afterProgress = widget.trainer['afterProgress'] as Map<String, String>? ?? {};
    exercises = (widget.trainer['exercise'] as String?)?.split(',').map((e) => e.trim()).toList() ?? [];
    beforeDate = widget.trainer['beforeDate'] ?? 'Before';
    afterDate = widget.trainer['afterDate'] ?? 'After';
    _saveAllProgressOnce();
  }

  Future<void> _saveAllProgressOnce() async {
    for (final exercise in exercises) {
      final afterStr = afterProgress[exercise] ?? '0';
      await DatabaseHelper().insertProgress({
        'trainer': widget.trainer['trainerName'] ?? 'Unknown',
        'exercise': exercise,
        'duration': int.tryParse(afterStr) ?? 0,
        'date': afterDate,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  'Trainer: ${widget.trainer['trainerName']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gym: ${widget.trainer['gymName']}',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Before: $beforeDate', style: const TextStyle(color: Colors.white)),
                    Text('After: $afterDate', style: const TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      final beforeStr = beforeProgress[exercise] ?? '-';
                      final afterStr = afterProgress[exercise] ?? '-';

                      String progressPercent = '-';
                      if (_isNumeric(beforeStr) && _isNumeric(afterStr)) {
                        final beforeVal = double.parse(beforeStr);
                        final afterVal = double.parse(afterStr);
                        if (beforeVal != 0) {
                          final change = ((afterVal - beforeVal) / beforeVal) * 100;
                          progressPercent = "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%";
                        }
                      }

                      return Card(
                        color: Colors.white.withOpacity(0.95),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Before: $beforeStr',
                                      style: const TextStyle(color: Colors.black)),
                                  Text('After: $afterStr',
                                      style: const TextStyle(color: Colors.black)),
                                  Text('Progress: $progressPercent',
                                      style: TextStyle(
                                          color: progressPercent.startsWith('-')
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }
}
