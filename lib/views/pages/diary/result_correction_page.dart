import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/analyzing_food.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:get/get.dart';

class ResultCorrectionPage extends StatefulWidget {
  const ResultCorrectionPage({super.key});

  @override
  State<ResultCorrectionPage> createState() => _ResultCorrectionPageState();
}

class _ResultCorrectionPageState extends State<ResultCorrectionPage> {
  final TextEditingController _correctionController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _correctionController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid = _correctionController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _correctionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            HeaderContainer(
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Image.asset('assets/icons/Back.png'),
                ),
                title: AppText(
                  'Result correction',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                centerTitle: true,
              ),
            ),

            // Divider
            Divider(height: 1, color: Colors.grey[300]),

            // Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text input field
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: TextField(
                      controller: _correctionController,
                      maxLines: 10,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText:
                            'Example: Missing tomato sauce and green olives.',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColor.primaryColor),
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            const Spacer(),
            // Correct result button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppButton(
                label: 'Correct result',
                ontap:
                    _isFormValid
                        ? () {
                          print(
                            'Correction submitted: ${_correctionController.text}',
                          );
                          Get.to(() => AnalyzingFoodPage());
                        }
                        : null,
                bgColor:
                    _isFormValid ? AppColor.primaryColor : Colors.grey[300],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
