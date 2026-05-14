// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../Core/utils/Colors.dart';

class Container_Exercise extends StatelessWidget {
  const Container_Exercise({
    Key? key,
    required this.onTap,
    required this.Day,
    required this.image,
    this.activity1,
    this.activity2,
    this.activity3,
    this.description1,
    this.description2,
    this.description3,
    this.duration1,
    this.duration2,
    this.duration3,
  }) : super(key: key);

  final Function onTap;
  final String Day;
  final String? activity1;
  final String? activity2;
  final String? activity3;
  final String? description1;
  final String? description2;
  final String? description3;
  final String? duration1;
  final String? duration2;
  final String? duration3;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.background,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                imageUrl: image.isNotEmpty
                    ? image
                    : 'https://buzzrx.s3.amazonaws.com/d1c6326d-04b2-48f9-95df-9e5d2b492bfe/WhyDoExerciseNeedsVaryBetweenIndividuals.png',
              ),
            ),
            const Gap(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Day,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    if (activity1 != null && activity1!.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              activity1!,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Gap(10), // Adjust gap to fit better
                          Text(
                            duration1 ?? ' ',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const Gap(5),
                    if (activity2 != null && activity2!.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              activity2!,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Gap(10), // Adjust gap to fit better
                          Text(
                            duration2 ?? ' ',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const Gap(5),
                    if (activity3 != null && activity3!.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              activity3!,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Gap(10), // Adjust gap to fit better
                          Text(
                            duration3 ?? ' ',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
}
