import 'package:cloud_firestore/cloud_firestore.dart';

final membersDb = FirebaseFirestore.instance.collection("members");

final requestsDb = FirebaseFirestore.instance.collection("requests");
