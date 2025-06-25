// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:e_library/controllers/AuthController.dart';

// class EditProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.find<AuthController>();

//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Profile')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 authController.pickProfileImage();
//               },
//               child: Obx(() {
//                 return CircleAvatar(
//                   radius: 50,
//                   backgroundImage: authController.selectedProfileImage.value !=
//                           null
//                       ? FileImage(authController.selectedProfileImage.value!)
//                       : NetworkImage(
//                           FirebaseAuth.instance.currentUser?.photoURL ??
//                               'https://example.com/default-profile.png'),
//                   child: authController.selectedProfileImage.value == null
//                       ? Center(
//                           child: authController.isProfileImageUploading.value
//                               ? CircularProgressIndicator()
//                               : Icon(Icons.camera_alt, color: Colors.white),
//                         )
//                       : null,
//                 );
//               }),
//             ),
//             Obx(() {
//               return TextField(
//                 controller:
//                     TextEditingController(text: authController.username.value),
//                 onChanged: (value) {
//                   authController.username.value = value;
//                 },
//                 decoration: InputDecoration(labelText: 'Username'),
//               );
//             }),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await authController.updateProfile(
//                   authController.username.value,
//                   authController.selectedProfileImage.value,
//                 );
//                 Get.back(); // Navigate back
//               },
//               child: Text('Save Changes'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
