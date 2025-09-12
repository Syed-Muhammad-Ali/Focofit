// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focofit/views/widgets/text.dart';

//common textfield

class AppTextfield extends StatefulWidget {
  Widget? prefixIcon;
  Widget? suffixIcon;
  Widget? errorWidget;
  Function()? onTap;
  Function(String)? onchanged;
  String? Function(String?)? validator;
  String? hint;
  Widget? subWidget;
  String? labelText;
  Color? filledColor;
  Color? borderColor;
  final TextEditingController ctr;
  TextInputType? textInputType;
  double? height;
  int? maxLength;
  double? width;
  double bottomSpace;
  double? radius;
  bool? readOnly;
  bool isPasswordField;
  bool isUnderlined;
  FocusNode? focusNode;
  bool hideKeyboard;
  int? maximumLines;
  int? minimumLines;
  String? title;
  TextCapitalization? textCapitalization;
  bool? useCountFormater;

  AppTextfield({
    super.key,
    this.prefixIcon,
    this.readOnly,
    this.errorWidget,
    this.validator,
    this.hint = '',
    this.subWidget,
    this.bottomSpace = 12,
    this.suffixIcon,
    required this.ctr,
    this.height,
    this.onTap,
    this.borderColor,
    this.isPasswordField = false,
    this.onchanged,
    this.textInputType,
    this.maxLength,
    this.radius,
    this.filledColor,
    this.maximumLines,
    this.minimumLines,
    this.width,
    this.focusNode,
    this.labelText,
    this.isUnderlined = false,
    this.hideKeyboard = true,
    this.textCapitalization,
    this.useCountFormater,
    this.title,
  });

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  bool isObscure = true;

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            widget.title ?? '',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff999999),
          ),
          SizedBox(height: widget.title != null ? 4 : 0),
          SizedBox(
            height: widget.height,
            child: TextFormField(
              onTapOutside: (event) {
                if (widget.hideKeyboard) {
                  _focusNode.unfocus();
                  // FocusScope.of(context).unfocus();
                }
              },
              inputFormatters:
                  (widget.useCountFormater ?? false)
                      ? [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[\d.]'),
                        ), // Allow only digits and period
                      ]
                      : null,
              focusNode: widget.focusNode ?? _focusNode,
              onChanged: widget.onchanged ?? (value) {},
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.sentences,
              onTap: widget.onTap,
              maxLines: widget.maximumLines ?? 1,
              minLines: widget.minimumLines ?? 1,
              readOnly: widget.readOnly ?? false,
              controller: widget.ctr,
              maxLength: widget.maxLength,
              keyboardType: widget.textInputType,
              obscureText: widget.isPasswordField ? isObscure : false,
              obscuringCharacter: '*',
              validator: widget.validator,
              style: TextStyle(
                color: Color(0xff999999),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: TextStyle(
                  color: Color(0xff999999),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.fromLTRB(
                  widget.isUnderlined ? 0 : 10,
                  14,
                  12,
                  4,
                ),
                counterText: '',
                filled: widget.isUnderlined ? false : true,
                fillColor:
                    widget.isUnderlined
                        ? null
                        : (widget.filledColor ?? Colors.white.withOpacity(.3)),
                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: const BoxConstraints(
                  maxWidth: 50,
                  minWidth: 40,
                  minHeight: 40,
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 50,
                  minWidth: 40,
                  minHeight: 40,
                ),
                suffixIcon:
                    widget.isPasswordField
                        ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: Icon(
                            isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                            color: Color(0xff999999),
                          ),
                        )
                        : widget.suffixIcon,
                errorStyle: TextStyle(fontSize: 14, color: Colors.red),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: Color(0xff999999),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                focusedBorder: border(widget.borderColor ?? Color(0xff999999)),
                errorBorder: border(widget.borderColor ?? Color(0xff999999)),
                enabledBorder: border(
                  widget.borderColor ?? widget.borderColor ?? Color(0xff999999),
                ),
                border: border(
                  widget.borderColor ?? widget.borderColor ?? Color(0xff999999),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder border(Color color) {
    return widget.isUnderlined
        ? UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
        )
        : OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(widget.radius ?? 10),
        );
  }
}
