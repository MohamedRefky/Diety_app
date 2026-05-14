// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Admin/view/AdminHome.dart';
import 'package:diety/features/Home/view/widget/Custom-Container.dart';
import 'package:diety/features/Home/view/widget/chalenges.dart';
import 'package:diety/features/Home/view/widget/navbar.dart';
import 'package:diety/features/Search%20Food/view/Breakfast.dart';
import 'package:diety/features/Search%20Food/view/Dinner.dart';
import 'package:diety/features/Search%20Food/view/Lunch.dart';
import 'package:diety/features/Search%20Food/view/Snacks.dart';
import 'package:diety/features/User%20Detials/view/UserDitails.dart';
import 'package:diety/features/profile/view/gemini.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../Exersise/view/Exercise.dart';
import '../../../profile/view/profile.dart';
import '../../../profile/widget/styles.dart';
import '../widget/watertracker.dart';

class Home extends StatefulWidget {
  final NotificationResponse? response;
  static const route = "/Homee";

  const Home({super.key, this.response});
  @override
  State<Home> createState() => _HomeeState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _HomeeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _getUserdData();
    tz.initializeTimeZones();
    _resetRemainingCal();
  }

  late String CaloriesConsumed = '';
  late String caloriesRemining = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final double consumed = 0.0;
  final double remaining = 0.0;
  late double percent = 0.0;
  late double RemainingCal = 0.0;

  var date = DateFormat.yMd().format(DateTime.now());

  Future<void> _resetRemainingCal() async {
    // Get the current time
    final now = tz.TZDateTime.now(tz.local);
    // Calculate the time until the next midnight
    final nextMidnight = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
      43,
    );
    // Calculate the duration until the next midnight
    final durationUntilMidnight = nextMidnight.difference(now);
    // Schedule a task to reset RemainingCal to 0 at the next midnight
    await Future.delayed(durationUntilMidnight, () {
      setState(() {
        CaloriesConsumed = '0';
      });
    });
  }

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
        caloriesRemining = userDoc.get('Calories Remining');
        CaloriesConsumed = userDoc.get('CaloriesConsumed').toString();
      });
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
    double consumed = double.tryParse(CaloriesConsumed) ?? 0.0;
    double remaining = double.tryParse(caloriesRemining) ?? 0.0;
    RemainingCal = remaining - consumed;
    if (RemainingCal < 0) {
      RemainingCal = 0;
    } else {
      RemainingCal = RemainingCal;
    }

    if (consumed >= remaining) {
      percent = 1;
    } else {
      percent = consumed / remaining;
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
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
        leadingWidth: 190,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const UserDitails(),
                    ));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                    size: 25,
                  )),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 7)))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        date = DateFormat.yMd().format(value);
                      });
                    }
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      DateFormat.yMEd().format(DateTime.now()),
                      style: TextStyle(color: AppColors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const salomon_bottom_bar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.button.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        'Calories ',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Remining = Goal - Food ',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      CircularPercentIndicator(
                        animationDuration: 1000,
                        animation: true,
                        radius: 60,
                        lineWidth: 12,
                        percent: percent,
                        progressColor: Colors.blue,
                        backgroundColor: AppColors.background,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              RemainingCal.toStringAsFixed(1),
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              'Remining ',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Gap(70),
                      const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.bolt,
                              color: Colors.yellow,
                            ),
                            Gap(20),
                            Icon(
                              FontAwesomeIcons.utensils,
                              color: Colors.blueAccent,
                            ),
                          ]),
                      const Gap(10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Base Goal',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              caloriesRemining,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                            const Gap(5),
                            Text(
                              'Food',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              CaloriesConsumed,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ])
                    ],
                  ),
                ]),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Breakfast(),
                  ));
                },
                text: 'Breakfast',
                iconData1: CupertinoIcons.sun_dust_fill,
                iconColor: Colors.yellow,
                iconData2: CupertinoIcons.plus,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Lunch(),
                  ));
                },
                text: 'Lunch',
                iconData1: CupertinoIcons.sun_max_fill,
                iconColor: const Color(0xff00b4f2),
                iconData2: CupertinoIcons.plus,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () {
                  addDataFromFileToFirestore();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Dinner(),
                  ));
                },
                text: 'Dinner',
                iconData1: CupertinoIcons.sun_haze,
                iconColor: const Color(0xfff69875),
                iconData2: CupertinoIcons.plus,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Snacks(),
                  ));
                },
                text: 'Snacks/Other',
                iconData1: Icons.dark_mode,
                iconColor: const Color(0xff915bbf),
                iconData2: CupertinoIcons.plus,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Exercise(),
                  ));
                },
                text: 'Add Exercise/Sleep',
                iconData1: Icons.directions_run_outlined,
                iconColor: const Color.fromRGBO(105, 111, 125, 1.0),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.normal),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pase Goal",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${caloriesRemining.toString()} cal',
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Your Food",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${CaloriesConsumed.toString()} cal',
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xff616570),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'percent',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${(percent * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset('Images/shap.jpg'))
                ],
              ),
              const Divider(
                color: Color(0xff616570),
              ),
              const Gap(10),
              const WaterTrackerWidget(),
              const Gap(10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 13),
                child: const Text(
                  'Challenges',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 150,
                color: AppColors.background,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Admin_Home(),
                          ));
                        },
                        icon: Icon(CupertinoIcons.chart_bar_alt_fill,
                            color: AppColors.button, size: 50),
                      ),
                      Text(
                        "Album",
                        style: TextStyle(color: AppColors.button),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
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
}

Future<void> addDataFromFileToFirestore() async {
  try {
    // Load file content from assets
    String fileContent = await rootBundle.loadString('assets/plan.json');

    // Parse the JSON content into a List
    List<dynamic> jsonDataList = jsonDecode(fileContent);

    // Assuming there's only one element in the list
    if (jsonDataList.isNotEmpty) {
      Map<String, dynamic> jsonData = jsonDataList.first;

      // Initialize Firebase
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add data to Firestore
      await firestore.collection('exercise_plans').doc('plan6').set(jsonData);

      print('Data from file added to Firestore successfully');
    } else {
      print('No data found in the file.');
    }
  } catch (error) {
    print('Error adding data from file to Firestore: $error');
  }
}
