// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/adding_meal/describe_meal/describe_meal_page.dart';
import 'package:focofit/views/pages/adding_meal/register_screen_adding_meal/register_screen_adding_meal.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

enum ScanType { food, barcode, nutrition }

class CameraScreen extends StatefulWidget {
  final ScanType scanType;

  const CameraScreen({super.key, required this.scanType});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isFlashOn = false;
  XFile? _capturedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isDisposed = false;

  bool _isBarcodeLoading = false;
  bool _showBarcodeTextField = false;
  bool _showEnterBarcodeText = false;

  // 🔹 Loader variables
  double _progress = 0.0;
  int _currentStep = 0;
  Timer? _timer;

  final List<String> _progressMessages = [
    'Identifying food...',
    'Analyzing nutrients...',
    'Preparing meal planner...',
    'Calculating calories...',
    'Finalizing results...',
    'Almost done...',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _disposeCamera();
    super.dispose();
  }

  @override
  void deactivate() {
    // Dispose camera when widget is deactivated (e.g., when navigating away)
    _disposeCamera();
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      if (!_isDisposed && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isDisposed && mounted) {
            _initializeCamera();
          }
        });
      }
    }
  }

  Future<void> _initializeCamera() async {
    if (_isDisposed) return;

    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty && !_isDisposed) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        await _cameraController!.initialize();
        // Check flash support
        _checkFlashSupport();
        if (mounted && !_isDisposed) {
          setState(() {
            _isInitialized = true;
          });
          print('📷 Camera initialization complete - UI updated');
        }
      } else {
        print('❌ No cameras available or disposed');
      }
    } catch (e) {
      print('❌ Error initializing camera: $e');
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
    }
  }

  void _checkFlashSupport() {
    if (_cameraController?.value.isInitialized == true) {
      if (kDebugMode) {
        print('Camera initialized successfully');
        print('Flash modes supported: ${_cameraController!.value.flashMode}');
        print('Camera description: ${_cameras![0].name}');
      }
    }
  }

  void _disposeCamera() {
    if (_cameraController != null) {
      try {
        _cameraController!.dispose();
      } catch (e) {
        debugPrint("❌ Error disposing camera: $e");
      }
      _cameraController = null;
    }
    _isInitialized = false;
  }

  Future<void> _captureImage() async {
    if (_cameraController != null &&
        _cameraController!.value.isInitialized &&
        !_isDisposed) {
      try {
        final XFile image = await _cameraController!.takePicture();

        // Crop the image to the focused area
        final croppedImage = await _cropImageToFocusedArea(image.path);

        if (!_isDisposed) {
          setState(() {
            _capturedImage = croppedImage;
          });

          // Start analysis process
          // _analyzeImage(croppedImage.path);
        }
      } catch (e) {
        debugPrint("❌ Error capturing image: $e");
      }
    }
  }

  Future<XFile> _cropImageToFocusedArea(String imagePath) async {
    try {
      print('✂️ Starting image cropping for: $imagePath');

      // Get the focused area rectangle
      final screenSize = MediaQuery.of(context).size;
      final focusedWidth = screenSize.width * 0.86;
      final focusedHeight = screenSize.height * 0.4;
      final focusedLeft = (screenSize.width - focusedWidth) / 2;
      final focusedTop = (screenSize.height - focusedHeight) / 2;

      print('✂️ Screen size: ${screenSize.width}x${screenSize.height}');
      print(
        '✂️ Focused area: ${focusedWidth}x${focusedHeight} at (${focusedLeft}, ${focusedTop})',
      );

      // Create a temporary file for the cropped image
      final tempDir = await getTemporaryDirectory();
      final tempPath =
          '${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Use image package to crop the image
      print('✂️ Reading image file...');
      final File imageFile = File(imagePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      print('✂️ Image bytes read: ${imageBytes.length} bytes');

      final img.Image? originalImage = img.decodeImage(imageBytes);
      print('✂️ Image decoded: ${originalImage != null}');

      if (originalImage != null) {
        print(
          '✂️ Original image size: ${originalImage.width}x${originalImage.height}',
        );

        // Calculate crop dimensions based on image resolution
        final double scaleX = originalImage.width / screenSize.width;
        final double scaleY = originalImage.height / screenSize.height;
        print('✂️ Scale factors: X=$scaleX, Y=$scaleY');

        final int cropX = (focusedLeft * scaleX).round();
        final int cropY = (focusedTop * scaleY).round();
        final int cropWidth = (focusedWidth * scaleX).round();
        final int cropHeight = (focusedHeight * scaleY).round();

        print(
          '✂️ Calculated crop: X=$cropX, Y=$cropY, W=$cropWidth, H=$cropHeight',
        );

        // Ensure crop dimensions are within image bounds
        final int safeCropX = cropX.clamp(0, originalImage.width - 1);
        final int safeCropY = cropY.clamp(0, originalImage.height - 1);
        final int safeCropWidth = cropWidth.clamp(
          1,
          originalImage.width - safeCropX,
        );
        final int safeCropHeight = cropHeight.clamp(
          1,
          originalImage.height - safeCropY,
        );

        print(
          '✂️ Safe crop: X=$safeCropX, Y=$safeCropY, W=$safeCropWidth, H=$safeCropHeight',
        );
        print(
          '✂️ Image bounds: W=${originalImage.width}, H=${originalImage.height}',
        );

        // Crop the image
        print('✂️ Starting image crop operation...');
        final img.Image croppedImage = img.copyCrop(
          originalImage,
          x: safeCropX,
          y: safeCropY,
          width: safeCropWidth,
          height: safeCropHeight,
        );
        print('✂️ Image cropped successfully');

        // Save the cropped image
        print('✂️ Saving cropped image to: $tempPath');
        final File croppedFile = File(tempPath);
        await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
        print('✂️ Cropped image saved successfully');

        return XFile(tempPath);
      } else {
        print('❌ Failed to decode image');
      }
    } catch (e) {
      print('❌ Error cropping image: $e');
      print('❌ Error type: ${e.runtimeType}');
      if (kDebugMode) {
        print('Error cropping image: $e');
      }
    }

    // Return original image if cropping fails
    print('✂️ Returning original image due to cropping failure');
    return XFile(imagePath);
  }

  Future<void> _openGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && !_isDisposed) {
        setState(() {
          _capturedImage = image;
        });
      }
    } catch (e) {
      debugPrint("❌ Error picking image: $e");
    }
  }

  void _toggleFlash() async {
    if (_cameraController != null &&
        _cameraController!.value.isInitialized &&
        !_isDisposed) {
      try {
        if (_isFlashOn) {
          await _cameraController!.setFlashMode(FlashMode.off);
        } else {
          await _cameraController!.setFlashMode(FlashMode.always);
        }
        setState(() {
          _isFlashOn = !_isFlashOn;
        });
      } catch (e) {
        debugPrint("❌ Error toggling flash: $e");
      }
    }
  }

  void _showNutritionErrorBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              Center(
                child: Image.asset(
                  'assets/icons/alert_error.png',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 16),
              // Description
              AppText(
                'We were unable to identify',
                textAlign: TextAlign.center,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.textColor,
              ),
              const SizedBox(height: 24),
              // Start button
              AppButton(
                label: 'Try again',
                weight: FontWeight.w500,
                bgColor: AppColor.primaryColor,
                ontap: () {
                  Navigator.pop(context);
                  setState(() {
                    _isBarcodeLoading = true;
                  });
                  _startProgress(goNextScreen: true);
                },
              ),
              const SizedBox(height: 12),
              // Schedule button
              AppButton(
                bgColor: Colors.white,
                borderColor: AppColor.textColor,
                useborder: true,
                txtClr: AppColor.textColor,
                ontap: () {
                  Get.to(() => DescribeMealPage());
                },
                label: 'Describe meal',
                isElevation: false,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _startProgress({bool goNextScreen = false}) {
    _progress = 0.0;
    _currentStep = 0;
    _timer?.cancel();

    const duration = Duration(milliseconds: 500);
    _timer = Timer.periodic(duration, (timer) {
      if (_currentStep < _progressMessages.length) {
        setState(() {
          _progress = (_currentStep + 1) / _progressMessages.length;
          _currentStep++;
        });
      } else {
        timer.cancel();

        if (goNextScreen) {
          // Nutrition flow
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterScreenAddingMeal(),
            ),
          );
        } else {
          // Barcode flow
          setState(() {
            _isBarcodeLoading = false;
            _showEnterBarcodeText = true;
          });
        }
      }
    });
  }

  Rect _getCaptureRect(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    switch (widget.scanType) {
      case ScanType.food:
        return Rect.fromCenter(
          center: Offset(screenSize.width / 2, screenSize.height / 2.4),
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.4,
        );
      case ScanType.barcode:
        return Rect.fromCenter(
          center: Offset(screenSize.width / 2, screenSize.height / 2.4),
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.2,
        );
      case ScanType.nutrition:
        return Rect.fromCenter(
          center: Offset(screenSize.width / 2, screenSize.height / 2.4),
          width: screenSize.width * 0.65,
          height: screenSize.height * 0.4,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Initializing Camera...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    final captureRect = _getCaptureRect(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            CameraPreview(_cameraController!),
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: CameraOverlayPainter(captureRect: captureRect),
            ),

            // Frame Corners
            Positioned(
              left: captureRect.left,
              top: captureRect.top,
              child: CustomPaint(
                size: Size(captureRect.width, captureRect.height),
                painter: CaptureFramePainter(),
              ),
            ),

            // Back button
            Positioned(
              top: 8,
              left: 10,
              child: IconButton(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  _disposeCamera();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            // Top text
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  "Hold firmly and avoid \nglare or shadows.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomButton(
                        'assets/icons/scan_food.png',
                        "Scan food",
                        ScanType.food,
                      ),
                      _buildBottomButton(
                        'assets/icons/scan_code.png',
                        "Scan code",
                        ScanType.barcode,
                      ),
                      _buildBottomButton(
                        'assets/icons/nutritional_scan.png',
                        "Nutritional Scan",
                        ScanType.nutrition,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (widget.scanType == ScanType.barcode) ...[
                    if (_isBarcodeLoading)
                      _buildLoader(showMessages: false)
                    else if (_showEnterBarcodeText)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showEnterBarcodeText = false;
                            _showBarcodeTextField = true;
                          });
                        },
                        child: const Text(
                          "Couldn't scan?\nEnter barcode >",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else if (_showBarcodeTextField)
                      AppTextfield(
                        hint: 'Enter barcode',
                        filledColor: AppColor.whiteColor,
                        suffixIcon: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, right: 4),
                            child: AppText(
                              "To send",
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: _openGallery,
                            child: Image.asset(
                              'assets/icons/gallery.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isBarcodeLoading = true;
                                _showEnterBarcodeText = false;
                                _showBarcodeTextField = false;
                              });

                              _startProgress(goNextScreen: false);
                            },
                            child: _buildShutterButton(),
                          ),
                          GestureDetector(
                            onTap: _toggleFlash,
                            child: Image.asset(
                              'assets/icons/flash.png',
                              height: 50,
                              color: _isFlashOn ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                  ]
                  // Nutrition UI
                  else if (widget.scanType == ScanType.nutrition) ...[
                    if (_isBarcodeLoading)
                      _buildLoader(showMessages: true)
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: _openGallery,
                            child: Image.asset(
                              'assets/icons/gallery.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showNutritionErrorBottomSheet();
                            },
                            child: _buildShutterButton(),
                          ),
                          GestureDetector(
                            onTap: _toggleFlash,
                            child: Image.asset(
                              'assets/icons/flash.png',
                              height: 50,
                              color: _isFlashOn ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                  ]
                  // Food UI
                  else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _openGallery,
                          child: Image.asset(
                            'assets/icons/gallery.png',
                            height: 50,
                            width: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: _captureImage,
                          child: _buildShutterButton(),
                        ),
                        GestureDetector(
                          onTap: _toggleFlash,
                          child: Image.asset(
                            'assets/icons/flash.png',
                            height: 50,
                            color: _isFlashOn ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader({bool showMessages = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showMessages) ...[
          AppText(
            _progressMessages[_currentStep < _progressMessages.length
                ? _currentStep
                : _progressMessages.length - 1],
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,

            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
        CircularPercentIndicator(
          radius: 30.0,
          lineWidth: 5.0,
          percent: _progress,
          backgroundColor: Colors.white,
          progressColor: AppColor.primaryColor,
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ],
    );
  }

  Widget _buildShutterButton() {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        shape: BoxShape.circle,
      ),
      child: const Padding(
        padding: EdgeInsets.all(3.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(String assetPath, String label, ScanType type) {
    final bool isSelected = widget.scanType == type;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CameraScreen(scanType: type)),
        );
      },
      child: Container(
        width: screenWidth * 0.28,
        height: screenHeight * 0.11,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.30) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: isSelected ? 2 : 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: screenHeight * 0.05,
              width: screenHeight * 0.05,
              color: Colors.white,
            ),
            const SizedBox(height: 6),
            AppText(
              label,
              color: Colors.white,
              fontSize: screenWidth * 0.030,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CameraOverlayPainter extends CustomPainter {
  final Rect captureRect;

  CameraOverlayPainter({required this.captureRect});

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint =
        Paint()
          ..color = Colors.black.withOpacity(0.6)
          ..style = PaintingStyle.fill;

    final fullScreenPath =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutoutPath =
        Path()..addRRect(
          RRect.fromRectAndRadius(captureRect, const Radius.circular(14)),
        );

    final overlayPath = Path.combine(
      PathOperation.difference,
      fullScreenPath,
      cutoutPath,
    );
    canvas.drawPath(overlayPath, overlayPaint);
  }

  @override
  bool shouldRepaint(covariant CameraOverlayPainter oldDelegate) {
    return captureRect != oldDelegate.captureRect;
  }
}

class CaptureFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cornerRadius = 10.0;
    final cornerLength = 55.0;
    final cornerThickness = 3.0;

    final cornerPaint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = cornerThickness
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    _drawRoundedCorner(
      canvas,
      cornerPaint,
      Offset(0, 0),
      cornerLength,
      cornerRadius,
      true,
      true,
    );
    _drawRoundedCorner(
      canvas,
      cornerPaint,
      Offset(size.width, 0),
      cornerLength,
      cornerRadius,
      false,
      true,
    );
    _drawRoundedCorner(
      canvas,
      cornerPaint,
      Offset(size.width, size.height),
      cornerLength,
      cornerRadius,
      false,
      false,
    );
    _drawRoundedCorner(
      canvas,
      cornerPaint,
      Offset(0, size.height),
      cornerLength,
      cornerRadius,
      true,
      false,
    );
  }

  void _drawRoundedCorner(
    Canvas canvas,
    Paint paint,
    Offset corner,
    double length,
    double radius,
    bool isLeft,
    bool isTop,
  ) {
    final path = Path();

    if (isLeft && isTop) {
      path.moveTo(corner.dx, corner.dy + length);
      path.lineTo(corner.dx, corner.dy + radius);
      path.arcToPoint(
        Offset(corner.dx + radius, corner.dy),
        radius: Radius.circular(radius),
      );
      path.lineTo(corner.dx + length, corner.dy);
    } else if (!isLeft && isTop) {
      path.moveTo(corner.dx - length, corner.dy);
      path.lineTo(corner.dx - radius, corner.dy);
      path.arcToPoint(
        Offset(corner.dx, corner.dy + radius),
        radius: Radius.circular(radius),
      );
      path.lineTo(corner.dx, corner.dy + length);
    } else if (!isLeft && !isTop) {
      path.moveTo(corner.dx, corner.dy - length);
      path.lineTo(corner.dx, corner.dy - radius);
      path.arcToPoint(
        Offset(corner.dx - radius, corner.dy),
        radius: Radius.circular(radius),
      );
      path.lineTo(corner.dx - length, corner.dy);
    } else {
      path.moveTo(corner.dx + length, corner.dy);
      path.lineTo(corner.dx + radius, corner.dy);
      path.arcToPoint(
        Offset(corner.dx, corner.dy - radius),
        radius: Radius.circular(radius),
      );
      path.lineTo(corner.dx, corner.dy - length);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
