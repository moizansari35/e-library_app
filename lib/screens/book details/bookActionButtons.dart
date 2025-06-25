import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/download_controller.dart';
import 'package:e_library/screens/book%20read/bookReadScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookActionButtons extends StatelessWidget {
  final String bookUrl;
  final String bookTitle;
  const BookActionButtons(
      {super.key, required this.bookUrl, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    DownloadController downloadController = Get.put(DownloadController());
    return Container(
      height: MediaQuery.sizeOf(context).height * 8 / 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(BookReadScreen(
                bookTitle: bookTitle,
                bookUrl: bookUrl,
              ));
            },
            child: Row(
              children: [
                SvgPicture.asset("Assets/Icons/book.svg"),
                const SizedBox(width: 10),
                Text(
                  "READ BOOK",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                ),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Obx(
            () => downloadController.isDownloading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.backgroundColor,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      downloadController.downloadFile(bookUrl, bookTitle);
                    },
                    child: Row(
                      children: [
                        // SvgPicture.asset("Assets/Icons/book.svg"),
                        const Icon(
                          Icons.download,
                          color: MyColors.whiteColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "DOWNLOAD BOOK",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
