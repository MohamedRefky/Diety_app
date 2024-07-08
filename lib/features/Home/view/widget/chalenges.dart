import 'dart:async';
import 'package:diety/features/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Chalengspage extends StatefulWidget {
  final CardItem item;

  const Chalengspage({Key? key, required this.item}) : super(key: key);

  @override
  _ChalengspageState createState() => _ChalengspageState();
}

class _ChalengspageState extends State<Chalengspage> {
  late Timer _timer;
  late DateTime _startTime;
  late Duration _elapsedTime = Duration.zero;
  static const Duration _targetDuration = Duration(days: 21);

  Future<void> _startTimer() async {
    _saveStartTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = DateTime.now().difference(_startTime);
        if (_elapsedTime >= _targetDuration) {
          _timer.cancel();
          _showSuccessDialog();
        }
      });
    });
  }

  Future<void> _loadStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    final startTimeMillis =
        prefs.getInt('start_time') ?? DateTime.now().millisecondsSinceEpoch;
    _startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMillis);
    _elapsedTime = DateTime.now().difference(_startTime);
    if (_elapsedTime < _targetDuration) {
      _startTimer();
    }
  }

  Future<void> _saveStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('start_time', _startTime.millisecondsSinceEpoch);
  }

  void _endCountdown() {
    setState(() {
    _elapsedTime = Duration.zero; // Set elapsed time to zero
    _startTime = DateTime.now(); // Update start time to current time
    _timer.cancel(); // Cancel the timer
    _saveStartTime(); // Save the updated start time
    _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.done),
          title: const Text('Challenge Success'),
          content: const Text(
              'Congratulations! You have successfully completed the challenge.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                Navigator.of(context).pop(); // Dismiss the Chalengspage dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadStartTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _elapsedTime.inDays;
    final hours = _elapsedTime.inHours % 24;
    final minutes = _elapsedTime.inMinutes % 60;
    final seconds = _elapsedTime.inSeconds % 60;
    return Dialog(
      backgroundColor: Colors.brown,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Try to stick to the challenge for at least 21 days. The clock starts now!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              '$days days, $hours hours, $minutes minutes, $seconds seconds',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _startTime=DateTime.now();
                _startTimer(); // Start the timer when the button is pressed
              },
              child: const Text('Start Challenge'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _endCountdown,
              child: const Text('End Challenge'),
            ),
          ],
        ),
      ),
    );
  }
}
