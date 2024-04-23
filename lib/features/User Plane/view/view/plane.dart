// ignore_for_file: depend_on_referenced_packages
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Asks/model/UserInfoProvider.dart';
import 'package:diety/features/Search%20Food/view/Breakfast.dart';
import 'package:diety/features/Search%20Food/view/Dinner.dart';
import 'package:diety/features/Search%20Food/view/Lunch.dart';
import 'package:diety/features/Search%20Food/view/Snacks.dart';
import 'package:diety/features/User%20Detials/view/UserDitails.dart';
import 'package:diety/features/User%20Goals/view/Lose_weight.dart';
// ignore: unused_import
import 'package:diety/features/User%20Plane/view/widget/Custom-Container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class Plane extends StatefulWidget {
  const Plane({super.key});

  @override
  State<Plane> createState() => _PlaneState();
}

class _PlaneState extends State<Plane> {
  UserInfoProvider userInfoProvider = UserInfoProvider();
  var date = DateFormat.yMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    String caloriesConsumed =
        Provider.of<UserInfoProvider>(context).caloriesConsumed;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            onPressed: () {
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
            icon: Icon(
              Icons.calendar_month,
              color: AppColors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.white,
            ),
          ),
        ],
        leadingWidth: 170,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                      color: AppColors.white,
                      //fontSize: 15,
                    ),
                  ),
                  Text(
                    DateFormat.yMEd().format(DateTime.now()),
                    style: TextStyle(color: AppColors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset('Images/shap.jpg')),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Calories Remining",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${CaloriseRemining.toInt().toString()} cal',
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
                              "Calories Consumed",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              caloriesConsumed.toString(),
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
                      fontWeight: FontWeight.bold)),
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
                onTap: () {},
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
                              "Calories Remining",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "2300",
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
                              "Calories Consumed",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "0",
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
                              "0% of RDI",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "2300",
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
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.chart_bar_alt_fill,
                        color: AppColors.button,
                        size: 50,
                      ),
                      Text(
                        "Today",
                        style: TextStyle(color: AppColors.button),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: AppColors.button,
                        size: 50,
                      ),
                      Text(
                        "Album",
                        style: TextStyle(color: AppColors.button),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.map,
                        color: AppColors.button,
                        size: 50,
                      ),
                      Text(
                        "Meal Plans",
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
}
