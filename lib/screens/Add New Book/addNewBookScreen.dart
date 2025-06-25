import 'package:e_library/Widgets/MyMultiLineTextFormField.dart';
import 'package:e_library/Widgets/MyTextFormField.dart';
import 'package:e_library/Widgets/backButton.dart';
import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewBookScreen extends StatelessWidget {
  const AddNewBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    final List<String> languages = ['ENGLISH', 'URDU'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              color: MyColors.primaryColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      const MyBackButton(),
                      const SizedBox(width: 50),
                      Text("Add New Book",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: MyColors.whiteColor))
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        bookController.pickImage();
                      },
                      child: Obx(
                        () => Container(
                          height: MediaQuery.sizeOf(context).height * 25 / 100,
                          width: MediaQuery.sizeOf(context).width * 40 / 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.backgroundColor,
                          ),
                          child: Center(
                            child: bookController.isImageUploading.value
                                ? CircularProgressIndicator(
                                    color: MyColors.primaryColor,
                                  )
                                : bookController.selectedImage.value == null
                                    ? Image.asset(
                                        "Assets/Icons/addImage.png",
                                        color: MyColors.primaryColor,
                                        fit: BoxFit.cover,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(bookController
                                            .selectedImage.value!),
                                      ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => Container(
                              height:
                                  MediaQuery.sizeOf(context).height * 7 / 100,
                              width:
                                  MediaQuery.sizeOf(context).width * 92 / 100,
                              decoration: BoxDecoration(
                                  color:
                                      bookController.selectedPDF.value == null
                                          ? MyColors.primaryColor
                                          : MyColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      bookController.selectedPDF.value == null
                                          ? Border.all(width: 0)
                                          : Border.all(
                                              width: 3,
                                              color: MyColors.primaryColor)),
                              child: bookController.isPdfUploading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: MyColors.whiteColor,
                                      ),
                                    )
                                  : bookController.selectedPDF.value == null
                                      ? InkWell(
                                          onTap: () {
                                            bookController.pickPDF();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "Assets/Icons/upload.png",
                                                color: MyColors.whiteColor,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "PDF Book Upload",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color:
                                                          MyColors.whiteColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            bookController.selectedPDF.value =
                                                null;
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "Assets/Icons/delete.png",
                                                width: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "Delete PDF",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFormField(
                      hintText: "Book Title",
                      icon: Icons.book,
                      tEcontroller: bookController.title),
                  const SizedBox(
                    height: 10,
                  ),
                  MyMultiLineTextFormField(
                      hintText: "Book Description",
                      tEcontroller: bookController.description),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFormField(
                      hintText: "Author Name",
                      icon: Icons.person,
                      tEcontroller: bookController.author),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFormField(
                      hintText: "About Author",
                      icon: Icons.description,
                      tEcontroller: bookController.aboutAuthor),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          isNumber: true,
                          hintText: "Pages",
                          icon: Icons.book,
                          tEcontroller: bookController.pages,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyTextFormField(
                          isNumber: true,
                          hintText: "Price",
                          icon: Icons.currency_rupee,
                          tEcontroller: bookController.price,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: bookController.selectedLanguage.value.isEmpty
                            ? 'Select a Language'
                            : '',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.language,
                          color: MyColors.primaryColor,
                        ),
                      ),
                      items: languages.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Text(
                            language,
                            style: TextStyle(color: MyColors.primaryColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        bookController.selectedLanguage.value = newValue ?? '';
                      },
                      value: bookController.selectedLanguage.value.isEmpty
                          ? null
                          : bookController.selectedLanguage.value,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 7 / 100,
                        width: MediaQuery.sizeOf(context).width * 92 / 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: MyColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cancel_outlined,
                              color: MyColors.primaryColor,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "CANCEL",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: MyColors.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Obx(
                      () => Container(
                        height: MediaQuery.sizeOf(context).height * 7 / 100,
                        width: MediaQuery.sizeOf(context).width * 92 / 100,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: bookController.isPostUploading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.whiteColor,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  bookController.createBook();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.upload,
                                      color: MyColors.whiteColor,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Post",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: MyColors.whiteColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
