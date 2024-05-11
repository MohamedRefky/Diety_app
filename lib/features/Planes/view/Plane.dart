import 'package:cached_network_image/cached_network_image.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/Home/view/widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../Core/utils/Colors.dart';
import '../widget/plan_model.dart';
import 'PlaneDetails.dart';

class Plane extends StatefulWidget {
  const Plane({super.key});

  @override
  State<Plane> createState() => _PlaneState();
}

bool isSelect = false;

class _PlaneState extends State<Plane> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030b18),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
        title: const Text(
          "Plans",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Home(),
              ));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      bottomNavigationBar: const salomon_bottom_bar(),
      body: StreamBuilder<List<Plan>>(
        stream: _firestoreService.getPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(
              "Error: ${snapshot.error}",
            );
          }

          if (snapshot.hasData) {
            final plans = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filter By:",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          showCheckmark: false,
                          backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                          padding: const EdgeInsets.all(8),
                          selectedColor: Colors.blue,
                          selectedShadowColor: AppColors.primaryColor,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: isSelect == true
                                      ? AppColors.primaryColor
                                      : Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          disabledColor: Colors.transparent,
                          label: Text(
                            "Free",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelect == true
                                        ? Colors.black
                                        : Colors.grey),
                          ),
                          selected: isSelect,
                          onSelected: (selected) {
                            isSelect = selected;
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FilterChip(
                          showCheckmark: false,
                          backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                          padding: const EdgeInsets.all(8),
                          selectedColor: Colors.blue,
                          selectedShadowColor: AppColors.primaryColor,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: isSelect == true
                                      ? AppColors.primaryColor
                                      : Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          disabledColor: Colors.transparent,
                          label: Text(
                            "Meal Plan",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelect == true
                                        ? Colors.black
                                        : Colors.grey),
                          ),
                          selected: isSelect,
                          onSelected: (selected) {
                            isSelect = selected;
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FilterChip(
                          showCheckmark: false,
                          backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                          padding: const EdgeInsets.all(8),
                          selectedColor: Colors.blue,
                          selectedShadowColor: AppColors.primaryColor,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: isSelect == true
                                      ? AppColors.primaryColor
                                      : Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          disabledColor: Colors.transparent,
                          label: Text(
                            "Nutrition",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelect == true
                                        ? Colors.black
                                        : Colors.grey),
                          ),
                          selected: isSelect,
                          onSelected: (selected) {
                            isSelect = selected;
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FilterChip(
                          showCheckmark: false,
                          backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                          padding: const EdgeInsets.all(8),
                          selectedColor: Colors.blue,
                          selectedShadowColor: AppColors.primaryColor,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: isSelect == true
                                      ? AppColors.primaryColor
                                      : Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60))),
                          disabledColor: Colors.transparent,
                          label: Text(
                            "Walking",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelect == true
                                        ? Colors.black
                                        : Colors.grey),
                          ),
                          selected: isSelect,
                          onSelected: (selected) {
                            isSelect = selected;
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  const Text(
                    "Available Plans",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: plans.length,
                        itemBuilder: (context, index) {
                          final plan =
                              plans[index]; // Get the current plan in the list
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlaneDetails(
                                          name: plan.name,
                                          image: plan.image,
                                          details: plan.details,
                                          duration: plan.duration,
                                          difficulty: plan.difficulty,
                                          chooseThisPlanIf:
                                              plan.chooseThisPlanIf,
                                          whatYouWillDo: plan.whatYouWillDo,
                                          schedule: plan.schedule,
                                          guidelines: plan.guidelines,
                                        )),
                              );
                            },
                            child: Card(
                              color: const Color(0xff202835).withAlpha(150),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    alignment: Alignment.topCenter,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    imageUrl: plan.image,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          plan.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Gap(5),
                                        Text(
                                          "${plan.duration} . Daily",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          }

          return const Text("No data available");
        },
      ),
    );
  }
}
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      /*Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filter By:",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    showCheckmark: false,
                    backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                    padding: const EdgeInsets.all(8),
                    selectedColor: Colors.blue,
                    selectedShadowColor: AppColors.primaryColor,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: isSelect == true
                                ? AppColors.primaryColor
                                : Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60))),
                    disabledColor: Colors.transparent,
                    label: Text(
                      "Free",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelect == true ? Colors.black : Colors.grey),
                    ),
                    selected: isSelect,
                    onSelected: (selected) {
                      isSelect = selected;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FilterChip(
                    showCheckmark: false,
                    backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                    padding: const EdgeInsets.all(8),
                    selectedColor: Colors.blue,
                    selectedShadowColor: AppColors.primaryColor,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: isSelect == true
                                ? AppColors.primaryColor
                                : Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60))),
                    disabledColor: Colors.transparent,
                    label: Text(
                      "Meal Plan",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelect == true ? Colors.black : Colors.grey),
                    ),
                    selected: isSelect,
                    onSelected: (selected) {
                      isSelect = selected;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FilterChip(
                    showCheckmark: false,
                    backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                    padding: const EdgeInsets.all(8),
                    selectedColor: Colors.blue,
                    selectedShadowColor: AppColors.primaryColor,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: isSelect == true
                                ? AppColors.primaryColor
                                : Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60))),
                    disabledColor: Colors.transparent,
                    label: Text(
                      "Nutrition",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelect == true ? Colors.black : Colors.grey),
                    ),
                    selected: isSelect,
                    onSelected: (selected) {
                      isSelect = selected;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FilterChip(
                    showCheckmark: false,
                    backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                    padding: const EdgeInsets.all(8),
                    selectedColor: Colors.blue,
                    selectedShadowColor: AppColors.primaryColor,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: isSelect == true
                                ? AppColors.primaryColor
                                : Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60))),
                    disabledColor: Colors.transparent,
                    label: Text(
                      "Walking",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelect == true ? Colors.black : Colors.grey),
                    ),
                    selected: isSelect,
                    onSelected: (selected) {
                      isSelect = selected;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),
            const Text(
              "Available Plans",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaneDetails(
                              name: name[index],
                              image: image[index],
                              details: details[index])),
                    );
                  },
                  child: Card(
                    color: const Color.fromRGBO(27, 30, 41, 1.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          image[index],
                          height: 150,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "28 days . Daily",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: image.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/