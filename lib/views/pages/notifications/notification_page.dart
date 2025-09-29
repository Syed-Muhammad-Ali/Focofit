import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/notifications/enable_notifications_page.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:get/get.dart';

import '../../widgets/header_container.dart' show HeaderContainer;
import '../../widgets/text.dart' show AppText;

class NotificationPage extends StatelessWidget {
  final controller = Get.put(NotificationController());
  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40, right: 16.0),
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
                  const Center(
                    child: AppText(
                      'Notifications',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EnableNotificationsPage());
                    },
                    child: SvgPicture.asset(
                      'assets/icons/setting-2.svg',
                      height: 39,
                      width: 39,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.notificationlist.length,
              itemBuilder: (context, index) {
                final notif = controller.notificationlist[index];
                return Column(
                  children: [
                    DiaryContainerTile(
                      child: SizedBox(
                        height: 65,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/notification-bing.svg',
                            ),
                            SizedBox(width: Get.width * 0.04),
                            AppText(
                              notif.desc,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor,
                            ),
                            const Spacer(),
                            AppText(
                              'remover',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                  ],
                );
              },
            ).paddingSymmetric(vertical: 10, horizontal: 10),
          ),
        ],
      ),
    );
  }
}

class NotificationsModel {
  final String desc;
  NotificationsModel({required this.desc});
}

class NotificationController extends GetxController {
  final List<NotificationsModel> notificationlist = [
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
    NotificationsModel(
      desc: 'Lorem notifications here you can\ncheck whenever you want',
    ),
  ];
}
