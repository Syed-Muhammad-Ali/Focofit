import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/analyzing_food.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';

class DescribeFood extends StatefulWidget {
  const DescribeFood({super.key});

  @override
  State<DescribeFood> createState() => _DescribeFoodState();
}

class _DescribeFoodState extends State<DescribeFood> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset('assets/icons/Back.png'),
        ),
        title: AppText(
          'Describe meal',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food name input field
            AppText(
              'Food name',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 8),
            // TextField(
            //   controller: _foodNameController,
            //   decoration: InputDecoration(
            //     hintText: 'Food name',
            //     hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
            //     filled: true,
            //     fillColor: Colors.grey[50],
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //       borderSide: BorderSide.none,
            //     ),
            //     contentPadding: EdgeInsets.symmetric(
            //       horizontal: 16,
            //       vertical: 16,
            //     ),
            //   ),
            // ),
            AppTextfield(ctr: _foodNameController, hint: 'Food name'),

            SizedBox(height: 24),

            // Description input field
            AppText(
              'Description',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              style: TextStyle(
                color: Color(0xff999999),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText:
                    'Example: 150g of yogurt, 1 cup of tea with blackberries and 2 tablespoons of oats',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                filled: true,
                fillColor: Colors.grey[50],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xff999999)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xff999999)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xff999999)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xff999999)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            SizedBox(height: 24),
            const Spacer(),
            // Info message
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

                SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    'All nutritional information is based on the description filled in the field above.',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            AppButton(
              label: 'Analyse',
              ontap:
                  _isFormValid
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnalyzingFoodPage(),
                          ),
                        );
                        // TODO: Navigate to analysis page
                        print('Food Name: ${_foodNameController.text}');
                        print('Description: ${_descriptionController.text}');
                      }
                      : null,
              bgColor: _isFormValid ? AppColor.primaryColor : Colors.grey[300],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
