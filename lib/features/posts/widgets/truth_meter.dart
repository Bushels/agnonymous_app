import 'package:flutter/material.dart';

class TruthMeter extends StatelessWidget {
  final int upvotes;
  final int downvotes;

  const TruthMeter({super.key, required this.upvotes, required this.downvotes});

  @override
  Widget build(BuildContext context) {
    final totalVotes = upvotes + downvotes;
    final truthfulness = totalVotes == 0 ? 0.5 : upvotes / totalVotes;

    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: truthfulness,
            backgroundColor: Colors.red,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${(truthfulness * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}