import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_library/Widgets/backButton.dart';
import 'package:e_library/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class BookDetailsCard extends StatelessWidget {
  final String coverUrl;
  final String title;
  final String author;
  final String description;
  final String rating;
  final String pages;
  final String langugae;
  const BookDetailsCard({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.author,
    required this.description,
    required this.rating,
    required this.pages,
    required this.langugae,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyBackButton(),
            SvgPicture.asset(
              "Assets/Icons/heart.svg",
              color: MyColors.whiteColor,
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: coverUrl,
            progressIndicatorBuilder: (context, url, progress) =>
                Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 165,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            width: MediaQuery.sizeOf(context).width * 40 / 100,
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ColumnTextSection(
              text: title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: MyColors.whiteColor,
                  ),
            ),
            const SizedBox(
              height: 2,
            ),
            ColumnTextSection(
              text: author,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: MyColors.greyColor,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            ColumnTextSection(
              text: description,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: MyColors.greyColor,
                  ),
              maxLines: 2, // Customize this based on your requirement
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RowTextSection(
                  // Reusable text section for rating
                  title: "Rating",
                  content: rating,
                ),
                RowTextSection(
                  // Reusable text section for pages
                  title: "Pages",
                  content: pages,
                ),
                RowTextSection(
                  // Reusable text section for language
                  title: "Language",
                  content: langugae,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ColumnTextSection extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextAlign textAlign;

  const ColumnTextSection({
    super.key,
    required this.text,
    this.style,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis, // To handle overflow gracefully
    );
  }
}

class RowTextSection extends StatelessWidget {
  final String title;
  final String content;
  final Color? titleColor;
  final Color? contentColor;
  final int? maxLines;

  const RowTextSection({
    super.key,
    required this.title,
    required this.content,
    this.titleColor,
    this.contentColor,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: titleColor ?? MyColors.greyColor,
              ),
          textAlign: TextAlign.center,
          maxLines: maxLines,
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: contentColor ?? MyColors.whiteColor,
              ),
          textAlign: TextAlign.center,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
