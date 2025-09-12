import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/controllers/fasting_controller.dart';
import 'package:focofit/models/fasting_model.dart';
import 'package:focofit/views/pages/fasting/fasting_plans_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class FastingPage extends StatelessWidget {
  const FastingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FastingController controller = Get.put(FastingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: const AppText(
      //     'Fasting',
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //     color: AppColor.textColor,
      //   ),
      // ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
              HeaderContainer(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height * .05),
                      AppText(
                        'Fasting',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),

              // Fasting cards
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.fastingList.length,
                    itemBuilder: (context, index) {
                      final fasting = controller.fastingList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                        child: _buildFastingCard(fasting, controller),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Add new fast button
              AppButton(
                label: 'Add new fast',
                bgColor: AppColor.primaryColor,
                txtClr: Colors.white,
                ontap: () => Get.to(() => FastingPlansPage()),
                height: 56,
                radius: 40,
                isElevation: false,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFastingCard(FastingModel fasting, FastingController controller) {
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status and action button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    fasting.statusText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textColor,
                  ),
                  GestureDetector(
                    onTap:
                        () =>
                            controller.handleAction(fasting.id, fasting.status),
                    child: AppText(
                      fasting.actionText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
              Divider(),
              const SizedBox(height: 16),
              // Time details
              _buildTimeRow('Starts at:', fasting.formattedStartTime),
              const SizedBox(height: 8),
              _buildTimeRow('Ends at:', fasting.formattedEndTime),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRow(String label, String time) {
    return Row(
      children: [
        // Orange accent bar
        Container(
          width: 3,
          height: 35,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        // Time text
        Expanded(
          child: AppText(
            '$label $time',
            fontSize: 14,
            color: AppColor.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
