import 'package:get/get.dart';

import 'bottomBar.dart';
import 'pages/authentication/login.dart';
import 'pages/authentication/signup.dart';

import 'pages/camera_module/pages/assign_camera.dart';
import 'pages/camera_module/pages/view_camera.dart';
import 'pages/chat_module/chat_list.dart';
import 'pages/dashboard.dart';
import 'pages/members_module/pages/add_member_page.dart';
import 'pages/members_module/pages/assign_analytics.dart';
import 'pages/members_module/pages/manage_members.dart';
import 'pages/my%20apartment/tab_page.dart';
import 'pages/my%20home/tab_page.dart';
import 'pages/my%20neighborhood/tab_page.dart';
import 'pages/notification_module/main_alerts_page.dart';
import 'pages/notification_module/primary_alerts.dart';
import 'pages/notification_module/secondary_alerts.dart';
import 'pages/sidebar%20pages/profile_page.dart';
import 'pages/splash.dart';
import 'pages/sidebar%20pages/change_password.dart';
import 'pages/sidebar%20pages/settings_page.dart';

import 'pages/my home/pages/baby_Monitor.dart';
import 'pages/my%20home/pages/door_survelliance.dart';
import 'pages/my%20home/pages/pet_watch.dart';
import 'pages/my%20home/pages/staff_monitor.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/signup', page: () => const SignupScreen()),
    GetPage(name: '/dashboard', page: () => const Dashboard()),
    // GetPage(name: '/bottombar', page: () =>  BottomBar()),
    GetPage(name: '/profile-page', page: () => ProfilePage()),
    GetPage(name: '/change-password', page: () => const ChangePasswordPage()),
    GetPage(name: '/settings', page: () => const SettingsPage()),
    GetPage(name: '/home', page: () => const MainHomePage()),
    GetPage(name: '/baby-monitor', page: () => const BabyMonitor()),
    GetPage(name: '/pet-watch', page: () => const PetWatch()),
    GetPage(name: '/staff-monitor', page: () => const StaffMonitor()),
    GetPage(name: '/door-survi', page: () => const DoorSurvelliance()),
    GetPage(name: '/apartment', page: () => MainApartmentPage()),
    GetPage(name: '/neighbourhood', page: () => MainNeighborhoodPage()),
    GetPage(name: '/view-camera', page: () => ViewCameras()),
    GetPage(name: '/manage-members', page: () => ManageMembers()),
    GetPage(name: '/add-member', page: () => const AddMemberPage()),
    GetPage(name: '/assign-camera', page: () => AssignCameraPage()),
    GetPage(name: '/alerts-page', page: () => const AlertBoard()),
    GetPage(name: '/primary-alerts', page: () => const PrimaryAlerts()),
    GetPage(name: '/secondary-alerts', page: () => const SecondaryAlerts()),
    GetPage(name: '/messages', page: () => const MembersChatScreen()),
    GetPage(name: '/assign-analytics', page: () => const AssignAnalytics()),
  ];
}
