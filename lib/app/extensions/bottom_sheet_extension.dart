import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';

extension BottomSheetExtension on BuildContext {
  Future<T?> showCustomBottomSheet<T>({
    required Widget widget,
    double padding = 0,
    bool safeArea = false,
    bool withBlur = false,
    bool isDismissible = true,
  }) async {
    return showModalBottomSheet<T?>(
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      context: this,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        final plainWidget = BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: withBlur ? 5 : 0,
            sigmaY: withBlur ? 5 : 0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //because upper safe area isn't included in bottom sheet context
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: isDismissible ? pop : null,
                child: Container(height: 100),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
                  child: widget,
                ),
              ),
            ],
          ),
        );
        return safeArea
            ? SafeArea(
                child: plainWidget,
              )
            : plainWidget;
      },
    );
  }
}
