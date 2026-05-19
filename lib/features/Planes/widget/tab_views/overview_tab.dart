import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OverviewTab extends StatelessWidget {
  final String details;
  final String duration;
  final String difficulty;
  final List<String> chooseThisPlanIf;
  final List<String> whatYouWillDo;
  final String guidelines;

  const OverviewTab({
    Key? key,
    required this.details,
    required this.duration,
    required this.difficulty,
    required this.chooseThisPlanIf,
    required this.whatYouWillDo,
    required this.guidelines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const Gap(20),
            Row(
              children: [
                const Text(
                  'Duration :',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                Text(
                  duration,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const Gap(10),
            const Row(
              children: [
                Text(
                  'Time Per Week :',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(),
                Text(
                  'Daily',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Text(
                  'Difficulty :',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                Text(
                  difficulty,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose This Plan If',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              chooseThisPlanIf
                  .map((item) => '• $item')
                  .join(' \n  \n'),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'What You Will Do ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              whatYouWillDo.join('\n\n'),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Guidelines',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              guidelines,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
