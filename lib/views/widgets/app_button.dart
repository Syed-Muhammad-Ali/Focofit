// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

//common button

class AppButton extends StatelessWidget {
  Color? txtClr;
  String label;
  VoidCallback? ontap;
  Row? rowElements;
  Color? bgColor;
  Color? borderColor;
  double? height;
  double? width;
  double? txtSize;
  double? radius;
  bool useborder;
  FontWeight? weight;
  EdgeInsets? padding;
  bool? isElevation;

  AppButton({
    super.key,
    required this.label,
    this.ontap,
    this.rowElements,
    this.bgColor,
    this.borderColor,
    this.useborder = true,
    this.txtClr,
    this.height,
    this.radius,
    this.width,
    this.txtSize = 16,
    this.weight,
    this.padding,
    this.isElevation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * .03,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(isElevation ?? true ? 2 : 0),
          padding: padding == null ? null : WidgetStatePropertyAll(padding!),
          backgroundColor: WidgetStateProperty.all(
            bgColor ?? AppColor.primaryColor,
          ),
          side: WidgetStatePropertyAll(
            (borderColor == null && bgColor == null)
                ? null
                : BorderSide(
                  color: borderColor ?? bgColor!,
                  width: useborder ? 2 : 0,
                ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 46),
            ),
          ),
          fixedSize: WidgetStateProperty.all(
            Size(width ?? MediaQuery.of(context).size.width, height ?? 56),
          ),
        ),
        onPressed: ontap,
        child:
            rowElements ??
            AppText(
              label,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.ellipsis,
              color: txtClr ?? Colors.white,
              fontSize: txtSize,
              fontWeight: weight ?? FontWeight.bold,
            ),
      ),
    );
  }
}
