import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../Asks/view/Gender.dart';
import '../widget/styles.dart';

class PersonalDataCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const PersonalDataCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activity = userData['activity']?.toString() ?? '';
    final healthStatus = userData['HealthStatus']?.toString() ?? '';
    final age = userData['age']?.toString() ?? '';
    final height = userData['height']?.toString() ?? '';
    final weight = userData['weight']?.toString() ?? '';
    final gender = userData['gender']?.toString() ?? '';

    return Container(
      width: double.infinity,
      color: const Color(0xff151724),
      padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Data',
            style: getTitleStyle(fontSize: 20),
          ),
          const Gap(15),
          _buildRow('Activity Level :', activity),
          const Divider(thickness: 1.3, color: Colors.white24),
          _buildRow('Health Status :', healthStatus),
          const Divider(thickness: 1.3, color: Colors.white24),
          _buildRow('Age :', '$age Years'),
          const Divider(thickness: 1.3, color: Colors.white24),
          _buildRow('Height :', '$height CM'),
          const Divider(thickness: 1.3, color: Colors.white24),
          _buildRow('Weight :', '$weight KG'),
          const Divider(thickness: 1.3, color: Colors.white24),
          _buildRow('Gender :', gender),
          const Divider(thickness: 1.3, color: Colors.white24),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Gender(),
                    ),
                  );
                },
                child: Text(
                  'Restart And Edit Your Data',
                  style: getbodyStyle(fontSize: 18, color: Colors.blueAccent),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: getbodyStyle(fontSize: 18),
        ),
        const Spacer(),
        Text(
          value,
          style: getbodyStyle(fontSize: 18),
        ),
      ],
    );
  }
}
