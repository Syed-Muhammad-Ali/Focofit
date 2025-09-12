import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/models/dietry_model.dart';
import 'package:focofit/views/pages/authentication/register_flow/creating_plan_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class DietryPage extends StatefulWidget {
  const DietryPage({super.key});

  @override
  State<DietryPage> createState() => _DietryPageState();
}

class _DietryPageState extends State<DietryPage> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Image.asset('assets/icons/Back.png'),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: 1,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '10/10',
              textAlign: TextAlign.center,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Do you have any dietary restrictions?',
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dietryList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                dietryList[index].isSelected =
                                    !dietryList[index].isSelected;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      dietryList[index].isSelected
                                          ? AppColor.primaryColor
                                          : Color(0xffD2D2D2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  AppText(
                                    dietryList[index].name,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Gluten', 0),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Eggs', 1),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Nuts', 2),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Dairy', 3),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Seafood', 4),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Shellfish', 5),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Soy', 6),
                  // SizedBox(height: h * .02),
                  // _buildGenderItem('Sesame', 7),
                  // const Spacer(),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              child: SizedBox(
                width: w,
                child: AppButton(
                  label: 'Continue',
                  ontap: () {
                    Get.to(() => const CreatingPlanPage());
                  },
                  bgColor:
                      dietryList.any((element) => element.isSelected)
                          ? AppColor.primaryColor
                          : Color(0xffD2D2D2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
