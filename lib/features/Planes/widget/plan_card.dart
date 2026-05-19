import 'package:cached_network_image/cached_network_image.dart';
import 'package:diety/features/Planes/view/PlaneDetails.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'plan_model.dart';


class PlanCard extends StatelessWidget {
  final Plan plan;

  const PlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              chooseThisPlanIf: plan.chooseThisPlanIf,
              whatYouWillDo: plan.whatYouWillDo,
              schedule: plan.schedule,
              guidelines: plan.guidelines,
            ),
          ),
        );
      },
      child: Card(
        color: const Color(0xff202835).withAlpha(150),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'planImage${plan.image}',
              child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                alignment: Alignment.topCenter,
                height: 150,
                fit: BoxFit.cover,
                width: double.infinity,
                imageUrl: plan.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    "${plan.duration} . Daily",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
