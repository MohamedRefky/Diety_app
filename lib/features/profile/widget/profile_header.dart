import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../Core/utils/Colors.dart';
import '../view/SetupPage .dart';
import '../widget/styles.dart';

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String? profileUrl;

  const ProfileHeader({
    Key? key,
    required this.userData,
    this.profileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstName = userData['firstName']?.toString() ?? '';
    final lastName = userData['lastName']?.toString() ?? '';
    final email = userData['email']?.toString() ?? '';

    return Container(
      width: double.infinity,
      height: 130,
      color: const Color(0xff151724),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SetupPage(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: (profileUrl != null && profileUrl!.isNotEmpty)
                        ? NetworkImage(profileUrl!)
                        : const AssetImage('assets/Images/person.png') as ImageProvider,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello',
                style: getTitleStyle(),
              ),
              Row(
                children: [
                  Text(firstName, style: getbodyStyle()),
                  const Gap(5),
                  Text(lastName, style: getbodyStyle()),
                ],
              ),
              const Gap(8),
              Text(email, style: getsmallStyle()),
            ],
          ),
        ],
      ),
    );
  }
}
