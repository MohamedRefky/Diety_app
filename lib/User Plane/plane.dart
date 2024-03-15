import 'package:diety/User%20Plane/Search%20Food/Breakfast.dart';
import 'package:diety/User%20Plane/Search%20Food/Dinner.dart';
import 'package:diety/User%20Plane/Search%20Food/Lunch.dart';
import 'package:diety/User%20Plane/Search%20Food/Snacks.dart';
import 'package:diety/User%20Plane/widget/Custom-Container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Plane extends StatefulWidget {
  const Plane({super.key});

  @override
  State<Plane> createState() => _PlaneState();
}

class _PlaneState extends State<Plane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030b18),
      appBar: AppBar(
        backgroundColor: const Color(0xff272f3c),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              )),
        ],
        titleSpacing: 20,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
            dropdownColor: const Color.fromRGBO(39, 47, 60, 1.0),
            items: const [
              DropdownMenuItem(
                  child: Text(
                "Today",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ))
            ],
            onChanged: (value) {},
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
                  const Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Calories Remining",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "2300",
                              style: TextStyle(
                                color: Colors.white,
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
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                color: Colors.white,
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
                  color: const Color(0xff373b47),
                  text: 'Breakfast',
                  iconData1: CupertinoIcons.sun_dust_fill,
                  iconColor: Colors.yellow,
                  iconData2: CupertinoIcons.plus,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const Gap(10),
              CustomContainer(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Lunch(),
                  ));
                },
                color: const Color(0xff373b47),
                text: 'Lunch',
                iconData1: CupertinoIcons.sun_max_fill,
                iconColor: const Color(0xff00b4f2),
                iconData2: CupertinoIcons.plus,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Dinner(),
                  ));
                },
                color: const Color(0xff373b47),
                text: 'Dinner',
                iconData1: CupertinoIcons.sun_haze,
                iconColor: const Color(0xfff69875),
                iconData2: CupertinoIcons.plus,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () { Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Snacks(),
                  ));},
                color: const Color(0xff373b47),
                text: 'Snacks/Other',
                iconData1: Icons.dark_mode,
                iconColor: const Color(0xff915bbf),
                iconData2: CupertinoIcons.plus,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              CustomContainer(
                onTap: () {},
                color: const Color(0xff1a222f),
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Calories Remining",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "2300",
                              style: TextStyle(
                                color: Colors.white,
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
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "0% of RDI",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "2300",
                              style: TextStyle(
                                color: Colors.grey,
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
              const Divider(),
              const Gap(12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.chart_bar_alt_fill,
                        color: Colors.green,
                        size: 50,
                      ),
                      Text(
                        "Today",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: Colors.green,
                        size: 50,
                      ),
                      Text(
                        "Album",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.map,
                        color: Colors.green,
                        size: 50,
                      ),
                      Text(
                        "Meal Plans",
                        style: TextStyle(color: Colors.green),
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
