import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/diary/food_recorded_page.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ExercisesTile extends StatelessWidget {
  const ExercisesTile({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return DiaryContainerTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/exercises.png'),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Exercises',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    AppText(
                      'Daily goal: 100 / 1000 kcal',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.primaryColor,
                    child: Center(child: Icon(Icons.add, color: Colors.white)),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            ListView.builder(
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => FoodRecordedPage());
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 4,
                              fit: FlexFit.loose,
                              child: AppText(
                                'Outdoor running with weights on feet, 35 min.',
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            AppText(
                              '-56 kcal',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColor.greyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DinnerTile extends StatelessWidget {
  const DinnerTile({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return DiaryContainerTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/dinner.png'),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Dinner',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    AppText(
                      'Daily goal: 100 / 1000 kcal',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.primaryColor,
                    child: Center(child: Icon(Icons.add, color: Colors.white)),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            ListView.builder(
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => FoodRecordedPage());
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 4,
                              fit: FlexFit.loose,
                              child: AppText(
                                'Decaffeinated espresso without sugar, 100ml',
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            AppText(
                              '56 kcal',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColor.greyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LunchTile extends StatelessWidget {
  const LunchTile({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return DiaryContainerTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/lunch.png'),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Lunch',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    AppText(
                      'Daily goal: 225 / 1000 kcal',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.primaryColor,
                    child: Center(child: Icon(Icons.add, color: Colors.white)),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            ListView.builder(
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => FoodRecordedPage());
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 4,
                              fit: FlexFit.loose,
                              child: AppText(
                                'Decaffeinated espresso without sugar, 100ml',
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            AppText(
                              '56 kcal',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColor.greyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BrekaFastTile extends StatelessWidget {
  const BrekaFastTile({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return DiaryContainerTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/breakfast.png'),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Breakfast',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    AppText(
                      'My goal: 0 / 1000 kcal',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.primaryColor,
                    child: Center(child: Icon(Icons.add, color: Colors.white)),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            AppText(
              'You haven\'t made any entries yet',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class SnacksTile extends StatelessWidget {
  const SnacksTile({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return DiaryContainerTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/snacks.png'),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Snacks',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    AppText(
                      'Daily goal: 100 / 1000 kcal',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.primaryColor,
                    child: Center(child: Icon(Icons.add, color: Colors.white)),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            AppText(
              'You haven\'t made any entries yet',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
