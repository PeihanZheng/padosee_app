import 'package:flutter/material.dart';
import 'package:padosee/constants/strings.dart';
import 'package:padosee/widgets/analytics_card.dart';

class ApartmentPrimary extends StatefulWidget {
  const ApartmentPrimary({Key? key}) : super(key: key);

  @override
  State<ApartmentPrimary> createState() => _ApartmentPrimaryState();
}

class _ApartmentPrimaryState extends State<ApartmentPrimary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            children: const [
              AnalyticsCard(name: storeWatch),
              SizedBox(height: 10),
              AnalyticsCard(name: parkingWatch),
              SizedBox(height: 10),
              AnalyticsCard(name: commomAreaWatch),
            ],
          ),
        ),
      ],
    );
  }
}
