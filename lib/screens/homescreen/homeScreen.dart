import 'package:e_library/Widgets/BookCard.dart';
import 'package:e_library/Widgets/BookTile.dart';
import 'package:e_library/Widgets/homeAppBar.dart';
import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/auth_controller.dart';
import 'package:e_library/controllers/book_controller.dart';
import 'package:e_library/models/data.dart';
import 'package:e_library/screens/book%20details/bookdetails.dart';
import 'package:e_library/screens/homescreen/homeWidgets/homeShimmer.dart';
import 'package:e_library/screens/homescreen/homeWidgets/myCategoryCon.dart';
import 'package:e_library/screens/homescreen/homeWidgets/mySearchBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    AuthController authController = Get.put(AuthController());
    bookController.getAllBooks();
    bookController.getUserBooks();

    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: bookController.isLoading.value
              ? const HomeShimmer()
              : Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 50 / 100,
                      color: MyColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            const HomeAppBar(),
                            const SizedBox(height: 50),
                            Row(
                              children: [
                                Text(
                                  "Hey Whats'up✌️",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                ),
                                Text(
                                  authController
                                          .auth.currentUser?.displayName ??
                                      "Root User",
                                  // "${authController.auth.currentUser!.displayName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Time to read book and enhance your knowledge",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const MySearchBar(),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Topics",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: MyColors.whiteColor,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: categoryData
                                      .map((e) => MyCategoryContainer(
                                            iconName: e["icon"]!,
                                            btnName: e["lebel"]!,
                                          ))
                                      .toList()),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Trending",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: MyColors.blackColor,
                                  ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                          () => Row(
                            children: bookController.bookData
                                .map((e) => BookCard(
                                    coverUrl: e.coverUrl!,
                                    title: e.title!,
                                    ontap: () {
                                      Get.to(() => BookDetails(
                                            bookModel: e,
                                          ));
                                    }))
                                .toList(),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Others",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: MyColors.blackColor,
                                  ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: bookController.bookData
                            .map((e) => BookTile(
                                title: e.title!,
                                coverUrl: e.coverUrl!,
                                author: e.author!,
                                price: e.price!,
                                rating: e.rating,
                                numberOfRating: e.numberofRating,
                                ontap: () {}))
                            .toList(),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
