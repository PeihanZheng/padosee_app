import 'package:flutter/cupertino.dart';
import 'package:padosee/models/data_models/camera_model.dart';
import 'package:padosee/models/data_models/notifications_model.dart';
import 'package:padosee/models/data_models/user_model.dart';

ValueNotifier<UserModel> userData = ValueNotifier(UserModel());

ValueNotifier<bool> isLoiteringDetected = ValueNotifier<bool>(false);

ValueNotifier<bool> isIntrusionDetected = ValueNotifier<bool>(false);

ValueNotifier<bool> isFRDetected = ValueNotifier<bool>(false);

ValueNotifier<int> camerasCount = ValueNotifier<int>(0);

ValueNotifier<List<CameraModel>> assignedCameraList = ValueNotifier([]);

ValueNotifier<String> errorText = ValueNotifier('');

ValueNotifier<String> userRole = ValueNotifier("secondary");

ValueNotifier<List<UserModel>> usersList = ValueNotifier([]);

ValueNotifier<List<UserModel>> searchedList = ValueNotifier([]);

ValueNotifier<List<NotificationModel>> notificationsList = ValueNotifier([]);

ValueNotifier<List<NotificationModel>> requestsList = ValueNotifier([]);

ValueNotifier<List> chatList = ValueNotifier([]);

ValueNotifier<List<String>> cameraLocationsList = ValueNotifier([]);

ValueNotifier<bool> isConfirmed = ValueNotifier(false);

ValueNotifier<List<dynamic>> assignedAnalyticsList = ValueNotifier([]);

ValueNotifier<bool> isEnabled = ValueNotifier(false);

ValueNotifier<String> newAccessToken = ValueNotifier("");
