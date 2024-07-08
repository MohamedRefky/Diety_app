import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  _WaterTrackerState createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  late String waterIntake = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _getUserdData();
  }

  Future<void> _getUserdData() async {
    User? user = _auth.currentUser;
    setState(() {
      _uid = user!.uid;
    });

    // Query Firestore for the user document using UID
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(_uid).get();
    setState(() {
      waterIntake = userDoc.get('waterIntake');
    });
  }

  double _currentWaterIntake = 0.0;

  final List<double> _glassIntakes = [
    0.25,
    0.25,
    0.25,
    0.25,
    0.25,
    0.25,
    0.25,
    0.25
  ];
  final List<bool> _isFilled = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  void _toggleGlass(int index) {
    setState(() {
      if (_isFilled[index]) {
        _currentWaterIntake -= _glassIntakes[index];
      } else {
        _currentWaterIntake += _glassIntakes[index];
      }
      _isFilled[index] = !_isFilled[index];

      // Check if all glasses are filled, then add a new empty glass
      if (_isFilled.every((filled) => filled)) {
        _glassIntakes.add(0.25);
        _isFilled.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff0096ff), // Change this to your desired color
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Water Tracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Water',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Goal: $waterIntake L',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${_currentWaterIntake.toStringAsFixed(2)} L',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                    _isFilled.length, (index) => _buildGlass(index)),
              ),
            ),
            const Gap(15)
          ],
        ),
      ),
    );
  }

  Widget _buildGlass(int index) {
    return GestureDetector(
      onTap: () => _toggleGlass(index),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipPath(
            clipper: GlassClipper(),
            child: Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          ClipPath(
            clipper: GlassClipper(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 40,
              height:
                  _isFilled[index] ? 60 : 0, // Height changes to fill the glass
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 62, 127, 239), // Water color
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const Column(
            children: [
              Icon(
                Icons.remove,
                color: Colors.white, // Icon color
              ),
              Icon(
                Icons.add,
                color: Color.fromARGB(255, 62, 127, 239), // Icon color
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GlassClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.2, size.height); // Start at bottom left
    path.lineTo(size.width * 0.8, size.height); // Bottom right
    path.lineTo(size.width, 0); // Top right
    path.lineTo(0, 0); // Top left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Reusable Widget
class WaterTrackerWidget extends StatelessWidget {
  const WaterTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const WaterTracker();
  }
}
