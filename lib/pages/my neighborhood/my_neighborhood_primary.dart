import 'package:flutter/material.dart';
import 'package:padosee/constants/strings.dart';
import 'package:padosee/widgets/analytics_card.dart';

class NeighborhoodPrimary extends StatefulWidget {
  const NeighborhoodPrimary({Key? key}) : super(key: key);

  @override
  State<NeighborhoodPrimary> createState() => _NeighborhoodPrimaryState();
}

class _NeighborhoodPrimaryState extends State<NeighborhoodPrimary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            children: const [
              AnalyticsCard(name: burglaryAlert),
              SizedBox(height: 10),
              AnalyticsCard(name: bannedCarAlert),
              SizedBox(height: 10),
              AnalyticsCard(name: noticeBoard),
            ],
          ),
        ),
      ],
    );
  }
}
