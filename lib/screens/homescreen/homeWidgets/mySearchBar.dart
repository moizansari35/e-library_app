import 'package:e_library/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          InkWell(
              onTap: () {
                bookController.getAllBooks();
              },
              child: Icon(
                Icons.search,
              )),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Search here . . .",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
