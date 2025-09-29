// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/receipes/revenues_details/revenues_details_page.dart';
import 'package:focofit/views/widgets/analyzing_food.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class CreateReceipesFoco extends StatefulWidget {
  const CreateReceipesFoco({super.key});

  @override
  State<CreateReceipesFoco> createState() => _CreateReceipesFocoState();
}

class _CreateReceipesFocoState extends State<CreateReceipesFoco> {
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _foodNameController.addListener(_checkFormValidity);
    _descriptionController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid =
          _foodNameController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40, right: 16),
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
                      'Create recipe',
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
          SizedBox(height: height * 0.02),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: height - 160),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextfield(
                          ctr: _foodNameController,
                          hint: 'Name of the food',
                        ),
                        SizedBox(height: height * 0.01),
                        AppTextfield(
                          ctr: _descriptionController,
                          title: 'Recipe description',
                          hint: 'Example: I am allergic to wheat and dairy.',
                          maximumLines: 5,
                          minimumLines: 5,
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: AppText(
                                  'i',
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AppText(
                                'All nutritional information is based on the description filled in the field above.',
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        AppButton(
                          label: 'Create recipe',
                          ontap:
                              _isFormValid
                                  ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => AnalyzingFoodPage(
                                              title: "Create recipe",
                                              onComplete: () {
                                                print(
                                                  "Custom action after analysis done!",
                                                );
                                                Get.to(
                                                  () =>
                                                      const RevenuesDetailsPage(),
                                                );
                                              },
                                            ),
                                      ),
                                    );

                                    print(
                                      'Food Name: ${_foodNameController.text}',
                                    );
                                    print(
                                      'Description: ${_descriptionController.text}',
                                    );
                                  }
                                  : null,
                          bgColor:
                              _isFormValid
                                  ? AppColor.primaryColor
                                  : Colors.grey[300],
                        ),

                        SizedBox(height: height * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
