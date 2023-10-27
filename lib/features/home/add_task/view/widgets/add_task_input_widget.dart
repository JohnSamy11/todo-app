import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';

class AddTaskInputWidget extends StatelessWidget {
  const AddTaskInputWidget({
    super.key,
    required this.title,
    required this.errorMessage,
    required this.child,
  });

  final String title;
  final String? errorMessage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: theme.textTheme.displayMedium,
        ),
        const SizedBox(height: 10),
        child,
        _ErrorWidget(
          errorMessage: errorMessage,
        ),
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final notShowing = errorMessage == null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: AnimatedSize(
        duration: 500.milliseconds,
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.topCenter,
        child: notShowing
            ? const SizedBox(height: 5)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      errorMessage.toString(),
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
