import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/receipes/revenues_details/revenues_details_page.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, String> recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => RevenuesDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Stack(
              children: [
                Image.network(
                  recipe["image"]!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(left: 8, bottom: 8, child: _tag(recipe["time"]!)),
                Positioned(right: 8, bottom: 8, child: _tag(recipe["kcal"]!)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              recipe["title"]!,
              maxLines: 2,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: AppText(
        text,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColor.textColor,
      ),
    );
  }
}
