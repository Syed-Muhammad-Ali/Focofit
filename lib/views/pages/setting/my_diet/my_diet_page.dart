import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:get/get.dart';

import '../../../../controllers/myDiet_controller.dart' show MyDietController;
import '../../../../models/myDiet_model.dart';
import '../../../widgets/header_container.dart';
import '../../../widgets/text.dart';

class MyDietPage extends StatelessWidget {
  const MyDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyDietController controller = Get.put(MyDietController());
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/icons/Back.png',
                      height: 39,
                      width: 39,
                    ),
                  ),
                  Center(
                    child: AppText(
                      'My Diet',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/Back.png',
                    height: 39,
                    width: 39,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.myDietList.length,
              itemBuilder: (context, index) {
                final mydiet = controller.myDietList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                  child: _buildFastingCard(mydiet, controller),
                );
              },
            ),
          ),
        ],
      ),

      // ✅ Put your button here
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AppButton(label: 'Save'),
      ),
    );
  }
}

Widget _buildFastingCard(MyDietModel mydiet, MyDietController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status and action button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  mydiet.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ],
            ),
            Divider(),
            const SizedBox(height: 16),
            AppText(
              textAlign: TextAlign.justify,
              mydiet.desc,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
            // Time details
          ],
        ),
      ),
    ),
  );
}
