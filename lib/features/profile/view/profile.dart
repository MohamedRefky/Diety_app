// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_field, unused_local_variable, unused_element

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Auth/SignUp.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/Home/view/widget/chalenges.dart';
import 'package:diety/features/Home/view/widget/navbar.dart';
import 'package:diety/features/profile/view/contact%20us%20.dart';
import 'package:diety/features/profile/view/gemini.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/utils/Colors.dart';
import '../../Auth/Login.dart';
import '../widget/styles.dart';
import 'SetupPage .dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class CardItem {
  final String urlImage;
  final String title;
  final String subtitle;

  const CardItem(
      {required this.urlImage, required this.title, required this.subtitle});
}

class _ProfileState extends State<Profile> {
  @override
  @override
  void initState() {
    super.initState();
    _getUser();
    _getUserdData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _uid;
  String? _imagePath;
  File? file;
  String? profileUrl;
  String? userID;
  Map<String, dynamic>? userData;
  String gender = '';
  late String age = '';
  late String height = '';
  late String weight = '';
  late String activity = '';
  late String email = '';
  late String caloriesRemining = '';
  late String dailyCalories = '';
  late String goalweight = '';
  late String waterIntake = '';
  late String sleepDuration = '';
  late String HealthStatus = '';
  late String BMI = '';
  late String idealweight = '';
  late String FirstName = '';
  late String LastName = '';

  Future<void> _getUserdData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _uid = user.uid;
      });

      // Query Firestore for the user document using UID
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_uid).get();
      setState(() {
        email = userDoc.get('email');
        height = userDoc.get('height');
        weight = userDoc.get('weight');
        activity = userDoc.get('activity');
        age = userDoc.get('age');
        gender = userDoc.get('gender');
        caloriesRemining = userDoc.get('Calories Remining');
        dailyCalories = userDoc.get('dailyCalories');
        goalweight = userDoc.get('Goal Weight');
        waterIntake = userDoc.get('waterIntake');
        sleepDuration = userDoc.get('sleepDuration');
        HealthStatus = userDoc.get('HealthStatus');
        BMI = userDoc.get('BMI');
        idealweight = userDoc.get('idealWeight');
        FirstName = userDoc.get('firstName') ?? '';
        LastName = userDoc.get('lastName');
      });
    }
  }

  Future<void> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedProfileUrl = prefs.getString('profileImageUrl');

    if (storedProfileUrl != null) {
      setState(() {
        profileUrl = storedProfileUrl;
      });
    } else {
      // If profile image URL is not stored locally, fetch it from Firestore
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userID = user.uid;
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .get();
        if (snapshot.exists) {
          Map<String, dynamic>? userData =
              snapshot.data() as Map<String, dynamic>?;
          if (userData != null && userData.containsKey('image')) {
            setState(() {
              profileUrl = userData['image'] as String?;
            });
          }
        }
      }
    }
  }

  List<CardItem> items = [
    const CardItem(
      urlImage:
          "https://images.emojiterra.com/google/noto-emoji/unicode-15.1/color/share/1f36b.jpg",
      title: 'No Chocolate',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://www.dictionary.com/e/wp-content/uploads/2018/11/lollipop-emoji.png",
      title: 'No Sugar',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://static.wikia.nocookie.net/emoji5546/images/9/93/Bombono.png/revision/latest?cb=20230810175804",
      title: 'No sweets',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://media.sketchfab.com/models/f62974b78d244172b4162bce312188b3/thumbnails/d71e95bb20b843e4973d966b32836742/798f3664b8fc4b7da851cb7063bd0122.jpeg",
      title: 'No Fast Food',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/hot-beverage.png",
      title: 'No Coffee',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/wine-glass.png",
      title: 'No Alcohol',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIBzdHb33w560vmwTp-EI38sZAyi6FW9WrclzUUKNyuA&s",
      title: 'No Pizza',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://images.emojiterra.com/google/noto-emoji/unicode-15.1/color/share/1f969.jpg",
      title: 'No Meat ',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage: "https://cdn-icons-png.flaticon.com/512/2836/2836507.png",
      title: 'No Chips',
      subtitle: "Strat Challenge",
    ),
    const CardItem(
      urlImage:
          "https://em-content.zobj.net/source/apple/391/cigarette_1f6ac.png",
      title: 'No Cigarettes',
      subtitle: "Strat Challenge",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff030b18),
        appBar: AppBar(
          backgroundColor: const Color(0xff151724),
          title: Text(
            'Profile',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GeminiAi(),
                ));
              },
              child: Row(
                children: [
                  Text(
                    'AI Coach',
                    style: getbodyStyle(fontSize: 18),
                  ),
                  const Gap(5),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.white,
                    backgroundImage: const AssetImage('Images/gemini logo.png'),
                  ),
                ],
              ),
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Home(),
                ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 30,
              )),
        ),
        bottomNavigationBar: const salomon_bottom_bar(),
        body: Column(
          children: [
            Container(
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
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const SetupPage(),
                            ));
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: (file != null)
                                ? FileImage(file!)
                                : (profileUrl != null)
                                    ? NetworkImage(profileUrl!)
                                    : const AssetImage('Images/person.png')
                                        as ImageProvider,
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
                          Text(FirstName, style: getbodyStyle()),
                          const Gap(5),
                          Text(LastName, style: getbodyStyle()),
                        ],
                      ),
                      const Gap(8),
                      Text(FirebaseAuth.instance.currentUser!.email!,
                          style: getsmallStyle()),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 390,
                      color: const Color(0xff151724),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Data',
                              style: getTitleStyle(fontSize: 20),
                            ),
                            const Gap(15),
                            Row(
                              children: [
                                Text(
                                  'Activity Level :',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                Text(
                                  activity,
                                  style: getbodyStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.3,
                              color: Colors.white24,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Helth Status :',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                Text(
                                  HealthStatus,
                                  style: getbodyStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.3,
                              color: Colors.white24,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Age :',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                Text(
                                  ' ${age.toString()} Years',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.3,
                              color: Colors.white24,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Height :',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                Text(
                                  '$height CM',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.3,
                              color: Colors.white24,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Weight :',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                Text(
                                  '$weight KG',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.3,
                              color: Colors.white24,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Gender :',
                                  style: getbodyStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                Text(
                                  " $gender",
                                  style: getbodyStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.3,
                              color: Colors.white24,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => const Gender(),
                                      ));
                                    },
                                    child: Text(
                                      'Restart And Edit Your Data',
                                      style: getbodyStyle(
                                          fontSize: 18,
                                          color: Colors.blueAccent),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ),
                    ),
                    const Gap(8),
                    Container(
                      width: double.infinity,
                      height: 320,
                      color: const Color(0xff151724),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Goals',
                              style: getTitleStyle(fontSize: 20),
                            ),
                            const Gap(15),
                            Text(
                              'Daily Calories ',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            Text(
                              '$dailyCalories Cal',
                              style: getsmallStyle(color: AppColors.grey),
                            ),
                            const Gap(15),
                            Text(
                              'Calories Remining ',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            Text(
                              '${caloriesRemining.toString()} Cal',
                              style: getsmallStyle(color: AppColors.grey),
                            ),
                            const Gap(15),
                            Text(
                              'Ideal Weight',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            Text(
                              '$idealweight kg',
                              style: getsmallStyle(color: AppColors.grey),
                            ),
                            const Gap(15),
                            Text(
                              'Weekly Goal',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            Text(
                              '$goalweight ',
                              style: getsmallStyle(color: AppColors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(8),
                    Container(
                      width: double.infinity,
                      height: 240,
                      color: const Color(0xff151724),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'More Important Data',
                              style: getTitleStyle(fontSize: 20),
                            ),
                            const Gap(15),
                            Text(
                              'Your BMI ',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            Text(
                              BMI,
                              style: getsmallStyle(color: AppColors.grey),
                            ),
                            const Gap(15),
                            Text(
                              'Water Intake',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            Text(
                              '$waterIntake per day',
                              style: getsmallStyle(color: AppColors.grey),
                            ),
                            const Gap(15),
                            Text(
                              'Sleep Duration',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            Text(
                              '$sleepDuration Hours',
                              style: getsmallStyle(color: AppColors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(8),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const contactus(),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: const Color(0xff151724),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Contact With Us',
                              style: getbodyStyle(
                                  fontSize: 18, color: Colors.blue),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const contactus(),
                                ));
                              },
                              icon: const Icon(
                                Icons.message_outlined,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Gap(8),
                    Container(
                      height: 150,
                      color: const Color(0xff151724),
                      child: ListView.separated(
                          padding: const EdgeInsets.all(4),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              buildcard(item: items[index]),
                          separatorBuilder: (context, _) => const SizedBox(
                                width: 8,
                              ),
                          itemCount: 10),
                    ),
                    const Gap(8),
                    InkWell(
                      onTap: () async {
                        GoogleSignIn googleSignIn = GoogleSignIn();
                        googleSignIn.disconnect();
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: const Color(0xff151724),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Log out',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.logout,
                                  color: AppColors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const Gap(8),
                    InkWell(
                      onTap: () async {
                        bool confirmDelete =
                            await _showConfirmationDialog(context);
                        if (confirmDelete) {
                          await deleteAccount();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: const Color(0xff151724),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Delete Account',
                              style: getbodyStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                bool confirmDelete =
                                    await _showConfirmationDialog(context);
                                if (confirmDelete) {
                                  await deleteAccount();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildcard({required CardItem item}) {
    return Column(
      children: [
        Expanded(
            child: AspectRatio(
          aspectRatio: 5 / 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.white,
              child: Ink.image(
                image: NetworkImage(item.urlImage),
                fit: BoxFit.contain,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Chalengspage(
                          item: item,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        )),
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          item.subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const SignUp(), // Redirect to a sign-in screen after deletion
        ));
      }
    } catch (e) {
      print('Error deleting user account: $e');
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content:
                const Text('Are you sure you want to delete your account?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false; // Return false if the dialog is dismissed
  }
}
