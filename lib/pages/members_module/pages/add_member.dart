// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:padosee/constants/strings.dart';
// import 'package:padosee/constants/theme/assets.dart';
// import 'package:padosee/constants/theme/shared_styles.dart';
// import 'package:padosee/constants/theme/theme_manager.dart';
// import 'package:padosee/pages/dashboard%20sub%20pages/members%20module/controller/members_controller.dart';
// import 'package:padosee/services/authentication_service.dart';

// import 'package:padosee/widgets/drawer.dart';

// class AddMember extends StatefulWidget {
//   const AddMember({Key? key}) : super(key: key);

//   @override
//   State<AddMember> createState() => _AddMemberState();
// }

// class _AddMemberState extends State<AddMember> {
//   final con = Get.put(MembersController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: con.scaffoldKey,
//       backgroundColor: ThemeManager.BACKGROUND_COLOR,
//       drawer: const MyDrawer(isFromDashboard: false),
//       appBar: AppBar(
//         centerTitle: true,
//         toolbarHeight: 65,
//         backgroundColor: ThemeManager.BACKGROUND_COLOR,
//         leading: IconButton(
//           onPressed: () {
//             con.scaffoldKey.currentState?.openDrawer();
//           },
//           icon: Icon(
//             Icons.menu,
//             size: 35,
//             color: ThemeManager.MENU_COLOR,
//           ),
//         ),
//         title: Text(
//           addmember,
//           style: textStyle1.copyWith(fontSize: 20, color: ThemeManager.TITLE_COLOR),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Icon(
//                     Icons.arrow_back,
//                     size: 33,
//                     color: Colors.blue,
//                   ),
//                   Text(
//                     back,
//                     style: textStyle1.copyWith(fontSize: 10, color: ThemeManager.TITLE_COLOR),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SafeArea(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 25, right: 25, top: Get.height * 0.02, bottom: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           profilePicWidget(),
//                           const SizedBox(height: 15),
//                           inputLabel(labelText: username),
//                           const SizedBox(height: 5),
//                           customTextFormField(
//                             hintText: usernameHT,
//                             controller: con.nameController,
//                             inputType: TextInputType.name,
//                           ),
//                           const SizedBox(height: 20),
//                           inputLabel(labelText: emailAddress),
//                           const SizedBox(height: 5),
//                           customTextFormField(
//                             hintText: emailAddressHT,
//                             controller: con.emailController,
//                             inputType: TextInputType.emailAddress,
//                           ),
//                           const SizedBox(height: 20),
//                           inputLabel(labelText: phoneNo),
//                           const SizedBox(height: 5),
//                           customTextFormField(
//                             hintText: phoneNoHT,
//                             controller: con.phoneController,
//                             inputType: TextInputType.phone,
//                           ),
//                           const SizedBox(height: 20),
//                           inputLabel(labelText: gender),
//                           const SizedBox(height: 5),
//                           genderSelection(),
//                           const SizedBox(height: 20),
//                           inputLabel(labelText: houseOrApartmentNo),
//                           const SizedBox(height: 5),
//                           customTextFormField(
//                             hintText: houseorApartmentNoHT,
//                             controller: con.houseController,
//                             inputType: TextInputType.text,
//                           ),
//                           const SizedBox(height: 20),
//                           inputLabel(labelText: address),
//                           const SizedBox(height: 5),
//                           addressTextField(),
//                           ValueListenableBuilder(
//                             valueListenable: errorText,
//                             builder: (context, value, _) {
//                               if (value != "") {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                                   child: Column(
//                                     children: [
//                                       const SizedBox(height: 20),
//                                       Text(
//                                         value.toString(),
//                                         textAlign: TextAlign.center,
//                                         style: textStyle1.copyWith(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w500),
//                                       ),
//                                       const SizedBox(height: 20),
//                                     ],
//                                   ),
//                                 );
//                               }
//                               return const SizedBox(height: 40);
//                             },
//                           ),
//                           TextButton(
//                             onPressed: () => con.addMember(),
//                             style: ButtonStyle(
//                               fixedSize: MaterialStateProperty.all(Size(Get.width, 50)),
//                               shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//                               side: MaterialStateProperty.all(
//                                 BorderSide(
//                                   width: 2,
//                                   color: Colors.blue.shade800,
//                                   style: BorderStyle.solid,
//                                 ),
//                               ),
//                               splashFactory: NoSplash.splashFactory,
//                             ),
//                             child: const Text(
//                               add,
//                               style: textStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (con.isLoading.value)
//             Container(
//               width: Get.width,
//               height: Get.height,
//               color: Colors.black45,
//               child: Center(
//                 child: Container(
//                   padding: const EdgeInsets.all(50),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget addressTextField() {
//     return TextFormField(
//       maxLines: 3,
//       controller: con.addressController,
//       keyboardType: TextInputType.text,
//       decoration: InputDecoration(
//         isDense: true,
//         isCollapsed: true,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         hintText: addressHT,
//         hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Colors.grey.withOpacity(0.5),
//           ),
//         ),
//         errorBorder: InputBorder.none,
//       ),
//       cursorColor: Colors.black,
//       style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
//     );
//   }

//   Widget genderSelection() {
//     return Obx(
//       () => SizedBox(
//         width: Get.width,
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey.withOpacity(0.5),
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Radio(
//                       visualDensity: VisualDensity.compact,
//                       value: 'Male',
//                       groupValue: con.genderGroup.value,
//                       onChanged: (value) {
//                         con.changeGenderValue(value.toString());
//                       },
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       male,
//                       style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey.withOpacity(0.5),
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Radio(
//                       visualDensity: VisualDensity.compact,
//                       value: 'Female',
//                       groupValue: con.genderGroup.value,
//                       onChanged: (value) {
//                         con.changeGenderValue(value.toString());
//                       },
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       female,
//                       style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget customTextFormField({String? hintText, TextEditingController? controller, TextInputType? inputType}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: inputType,
//       decoration: InputDecoration(
//         isDense: true,
//         isCollapsed: true,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
//         hintText: hintText,
//         hintStyle: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_HINT_TEXT_COLOR),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Colors.grey.withOpacity(0.5),
//           ),
//         ),
//         errorBorder: InputBorder.none,
//       ),
//       cursorColor: Colors.black,
//       style: textStyle2.copyWith(fontSize: 16, color: ThemeManager.APP_TEXT_COLOR),
//     );
//   }

//   Widget profilePicWidget() {
//     return Center(
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Container(
//               width: Get.width * .32,
//               height: Get.width * .32,
//               clipBehavior: Clip.hardEdge,
//               decoration: BoxDecoration(
//                 color: ThemeManager.BLUE_BORDER_COLOR,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: const Offset(0, 5),
//                     blurRadius: 10,
//                     spreadRadius: 3,
//                     color: ThemeManager.PROFILE_SHADOW_COLOR,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(100),
//                   child: Obx(
//                     () => Image.network(
//                       con.imageUrl.value,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 12,
//             right: 12,
//             child: GestureDetector(
//               onTap: () => con.pickImage(),
//               child: Container(
//                 width: 50,
//                 height: 50,
//                 clipBehavior: Clip.hardEdge,
//                 decoration: BoxDecoration(
//                   color: ThemeManager.BLUE_BORDER_COLOR,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       offset: const Offset(0, 5),
//                       blurRadius: 10,
//                       spreadRadius: 3,
//                       color: ThemeManager.CAMERA_SHOW_COLOR,
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(30),
//                     child: Image.asset(
//                       EDIT_PROFILE_CAMERA_ICON,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget inputLabel({String? labelText}) {
//     return Text(
//       labelText!,
//       style: textStyle1.copyWith(fontSize: 16, letterSpacing: 0.5, color: ThemeManager.INPUT_LABEL_COLOR),
//     );
//   }
// }
