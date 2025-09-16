import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/receipes/edit_receipe/edit_receipe_page.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class RevenuesDetailsPage extends StatefulWidget {
  const RevenuesDetailsPage({super.key});

  @override
  State<RevenuesDetailsPage> createState() => _RevenuesDetailsPageState();
}

class _RevenuesDetailsPageState extends State<RevenuesDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
                      'Revenues',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EditReceipePage());
                    },
                    child: Image.asset(
                      'assets/icons/edit.png',
                      height: 39,
                      width: 39,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Stack(
                        children: [
                          Image.network(
                            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500',
                            height: 290,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 8,
                            bottom: 8,
                            child: Row(
                              children: [
                                _tag("10 min"),
                                SizedBox(width: 14),
                                _tag('319 kcal'),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Image.asset(
                              'assets/icons/favorites.png',
                              height: 43,
                              width: 43,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    AppText(
                      "Smoked salmon with lemon sauce and chestnut sauce",
                      maxLines: 2,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    _buildCard(
                      iconPath: 'assets/icons/macros.png',
                      title: "Macronutrients",
                      child: Column(
                        children: [
                          const Divider(color: AppColor.dividerColor),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                _MacroItem(label: "Carboidrato", value: "300g"),
                                _MacroItem(label: "Proteína", value: "70g"),
                                _MacroItem(label: "Gordura", value: "130g"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      iconPath: 'assets/icons/ingredientes.png',
                      title: "Ingredients",
                      action: Icon(Icons.info, color: AppColor.primaryColor),
                      child: Column(
                        children: [
                          const Divider(),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100g",
                          ),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100ml",
                          ),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100ml",
                          ),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100ml",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      iconPath: 'assets/icons/modo.png',
                      title: "Preparation mode",
                      child: Column(
                        children: [
                          const Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _StepItem(
                                number: 1,
                                text: "Mix all ingredients in a bowl",
                              ),
                              _StepItem(
                                number: 2,
                                text: "Blend everything in a blender",
                              ),
                              _StepItem(
                                number: 3,
                                text: "Place in the oven and wait 40 minutes",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.campaign_outlined, size: 18),
                        const SizedBox(width: 8),
                        const Text("Did you find any errors?"),
                        const SizedBox(width: 4),
                        AppText(
                          "Report",
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
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

  Widget _buildCard({
    required String iconPath,
    required String title,
    Widget? action,
    required Widget child,
  }) {
    return DiaryContainerTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(iconPath, height: 20, width: 20, fit: BoxFit.contain),
              const SizedBox(width: 8),
              Expanded(
                child: AppText(
                  title,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textColor,
                ),
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _MacroItem extends StatelessWidget {
  final String label;
  final String value;

  const _MacroItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          label,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColor.textColor,
        ),
        const SizedBox(height: 4),
        AppText(
          value,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColor.textColor,
        ),
      ],
    );
  }
}

class _IngredientRow extends StatelessWidget {
  final String name;
  final String quantity;

  const _IngredientRow({required this.name, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              name,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
          ),
          Expanded(
            child: Divider(color: AppColor.dividerColor, thickness: 0.8),
          ),
          const SizedBox(width: 8),
          AppText(
            quantity,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.textColor,
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int number;
  final String text;

  const _StepItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number.", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Expanded(
            child: AppText(
              text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
