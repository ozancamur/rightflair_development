import 'package:flutter/material.dart';
import 'package:rightflair/core/components/text.dart';
import 'package:rightflair/core/constants/font/font_size.dart';
import 'package:rightflair/core/constants/string.dart';

import '../extensions/context.dart';

class DialogUtils {
  DialogUtils._();

  /// Hata dialogu göster
  static Future<void> showErrorDialog(
    BuildContext context, {
    required String message,
    String? title,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.colors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: title != null
              ? SizedBox(
                  width: double.maxFinite,
                  child: TextComponent(
                    text: title,
                    color: context.colors.primary,
                    size: FontSizeConstants.X_LARGE,
                    weight: FontWeight.w600,
                  ),
                )
              : null,
          content: SizedBox(
            width: double.maxFinite,
            child: TextComponent(
              text: message,
              color: context.colors.primaryContainer,
              size: FontSizeConstants.NORMAL,
              weight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: TextComponent(
                text: AppStrings.DIALOG_OK,
                color: Colors.red,
                size: FontSizeConstants.LARGE,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Başarı dialogu göster
  static Future<void> showSuccessDialog(
    BuildContext context, {
    required String message,
    String? title,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.colors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: title != null
              ? SizedBox(
                  width: double.maxFinite,
                  child: TextComponent(
                    text: title,
                    color: context.colors.primary,
                    size: FontSizeConstants.X_LARGE,
                    weight: FontWeight.w600,
                  ),
                )
              : null,
          content: SizedBox(
            width: double.maxFinite,
            child: TextComponent(
              text: message,
              color: context.colors.primaryContainer,
              size: FontSizeConstants.NORMAL,
              weight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: TextComponent(
                text: AppStrings.DIALOG_OK,
                color: context.colors.inverseSurface,
                size: FontSizeConstants.LARGE,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Onay dialogu göster
  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String message,
    String? title,
    String? confirmText,
    String? cancelText,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.colors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: title != null
              ? SizedBox(
                  width: double.maxFinite,
                  child: TextComponent(
                    text: title,
                    color: context.colors.primary,
                    size: FontSizeConstants.X_LARGE,
                    weight: FontWeight.w600,
                  ),
                )
              : null,
          content: SizedBox(
            width: double.maxFinite,
            child: TextComponent(
              text: message,
              color: context.colors.primaryContainer,
              size: FontSizeConstants.NORMAL,
              weight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: TextComponent(
                text: cancelText ?? AppStrings.DIALOG_CANCEL,
                color: context.colors.primaryContainer,
                size: FontSizeConstants.LARGE,
                weight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: TextComponent(
                text: confirmText ?? AppStrings.DIALOG_CONFIRM,
                color: Colors.red,
                size: FontSizeConstants.LARGE,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
