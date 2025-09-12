import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:focofit/models/fasting_model.dart';

class FastingController extends GetxController {
  final RxList<FastingModel> fastingList = <FastingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Sample data matching the image
    final sampleStartTime = DateTime(2024, 11, 10, 23, 0);
    final sampleEndTime = DateTime(2024, 11, 11, 15, 0);

    fastingList.addAll([
      FastingModel(
        id: '1',
        status: FastingStatus.inProgress,
        startTime: sampleStartTime,
        endTime: sampleEndTime,
        actionText: 'Stop',
      ),
      FastingModel(
        id: '2',
        status: FastingStatus.scheduled,
        startTime: sampleStartTime,
        endTime: sampleEndTime,
        actionText: 'Remove',
      ),
      FastingModel(
        id: '3',
        status: FastingStatus.completed,
        startTime: sampleStartTime,
        endTime: sampleEndTime,
        actionText: 'Hide',
      ),
    ]);
  }

  void stopFasting(String id) {
    final index = fastingList.indexWhere((fast) => fast.id == id);
    if (index != -1) {
      fastingList[index] = FastingModel(
        id: fastingList[index].id,
        status: FastingStatus.completed,
        startTime: fastingList[index].startTime,
        endTime: fastingList[index].endTime,
        actionText: 'Hide',
      );
    }
  }

  void removeFasting(String id) {
    fastingList.removeWhere((fast) => fast.id == id);
  }

  void hideFasting(String id) {
    fastingList.removeWhere((fast) => fast.id == id);
  }

  void handleAction(String id, FastingStatus status) {
    switch (status) {
      case FastingStatus.inProgress:
        _showStopConfirmationDialog(id);
        break;
      case FastingStatus.scheduled:
        _showDeleteConfirmationDialog(id);
        break;
      case FastingStatus.completed:
        _showHideConfirmationDialog(id);
        break;
    }
  }

  void _showStopConfirmationDialog(String id) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'Do you want to interrupt the fast?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              // Divider
              Container(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 16),
              // Body text
              const Text(
                'The timer will be reset and you will have to start again if you wish.',
                style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 24),
              // Continue button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9900),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Interrupt button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    _showShareBottomSheet();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Interrupt',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showDeleteConfirmationDialog(String id) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'Delete the scheduled fast?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              // Divider
              Container(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 16),
              // Body text
              const Text(
                'It will not be possible to recover the scheduled fasting plan after deletion.',
                style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 24),
              // Cancel button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9900),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Delete button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    removeFasting(id);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showHideConfirmationDialog(String id) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'Hide completed fast?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              // Divider
              Container(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 16),
              // Body text
              const Text(
                'You will still be able to view the history of the completed fast in the Profile section.',
                style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 24),
              // Cancel button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9900),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Hide button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    hideFasting(id);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF333333),
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Hide',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showShareBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'Share',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 24),
              // Fasting summary card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9900),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'I just finished a fast',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '16 hours',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '48 minutes',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '25 seconds',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 40,
                      height: 40,

                      child: Image.asset('assets/icons/logo.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Recent people section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent people',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildContactItem(
                      'Charlotte',
                      'assets/images/profile.png',
                      Icons.chat,
                      Colors.green,
                    ),
                    _buildContactItem(
                      'Kristin',
                      'assets/images/profile.png',
                      Icons.facebook,
                      Colors.blue,
                    ),
                    _buildContactItem(
                      'Clinton',
                      'assets/images/profile.png',
                      Icons.camera_alt,
                      Colors.purple,
                    ),
                    _buildContactItem(
                      'Maryland',
                      'assets/images/profile.png',
                      Icons.chat,
                      Colors.green,
                    ),
                    _buildContactItem(
                      'Ale',
                      'assets/images/profile.png',
                      Icons.person,
                      Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Social media section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Social media',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialMediaItem('WhatsApp', Icons.chat, Colors.green),
                  _buildSocialMediaItem(
                    'Facebook',
                    Icons.facebook,
                    Colors.blue,
                  ),
                  _buildSocialMediaItem(
                    'Instagram',
                    Icons.camera_alt,
                    Colors.purple,
                  ),
                  _buildSocialMediaItem(
                    'Telegram',
                    Icons.send,
                    Colors.lightBlue,
                  ),
                  _buildSocialMediaItem(
                    'Twitter',
                    Icons.flutter_dash,
                    Colors.lightBlue,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildContactItem(
    String name,
    String imagePath,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, size: 30, color: Colors.grey),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 12, color: Color(0xFF333333)),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaItem(String name, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 12, color: Color(0xFF333333)),
        ),
      ],
    );
  }
}
