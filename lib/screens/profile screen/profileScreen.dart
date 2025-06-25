import 'package:e_library/Widgets/BookTile.dart';
import 'package:e_library/Widgets/backButton.dart';
import 'package:e_library/config/colors.dart';
import 'package:e_library/const/const.dart';
import 'package:e_library/controllers/auth_controller.dart';
import 'package:e_library/controllers/book_controller.dart';
import 'package:e_library/screens/Add%20New%20Book/addNewBookScreen.dart';
import 'package:e_library/screens/book%20read/bookReadScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    BookController bookController = Get.put(BookController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewBookScreen());
        },
        child: const Icon(
          Icons.add,
          color: MyColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //height: MediaQuery.sizeOf(context).height * 40 / 100,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: MyColors.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyBackButton(),
                      Text("Your Profile",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: MyColors.whiteColor,
                              )),
                      IconButton(
                        onPressed: () {
                          authController.signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: MyColors.whiteColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: MyColors.whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        height: 120,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(100),
                          child: Image.network(
                            "${authController.auth.currentUser!.photoURL ?? defaultProfile}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${authController.auth.currentUser!.displayName ?? "Root User"}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: MyColors.whiteColor),
                  ),
                  Text(
                    "${authController.auth.currentUser!.email}",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: MyColors.greyColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Your Books",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: MyColors.blackColor,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => Column(
                        children: bookController.userBookData
                            .map((e) => BookTile(
                                  title: e.title!,
                                  coverUrl: e.coverUrl!,
                                  author: e.author!,
                                  price: e.price!,
                                  rating: e.rating,
                                  numberOfRating: e.numberofRating,
                                  ontap: () {
                                    Get.to(() => BookReadScreen(
                                          bookUrl: e.bookurl!,
                                          bookTitle: e.title!,
                                        ));
                                  },
                                ))
                            .toList(),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
