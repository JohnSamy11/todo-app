import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/app/themes/app_theme.dart';

class CustomEditText extends StatefulWidget {
  const CustomEditText({
    super.key,
    this.label,
    this.hint,
    this.hintStyle,
    this.height,
    this.borderRadius,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.hidden = false,
    this.enabled = true,
    this.showCounter = true,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.focusNode,
    this.onTapOutside,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onSave,
    this.color,
    this.borderColor,
    this.textColor,
    this.labelColor,
    this.leading,
    this.trailing,
    this.formatters,
    this.autoFocus = false,
  });

  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final double? height;
  final double? borderRadius;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool hidden;
  final bool showCounter;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(dynamic)? onTapOutside;
  final ValueChanged<String>? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Color? labelColor;
  final List<TextInputFormatter>? formatters;
  final bool autoFocus;

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SizedBox(
      // constraints: const BoxConstraints(minHeight: 30, maxHeight: 350),
      height: widget.height,
      child: Material(
        color: widget.color ?? theme.greyScale50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          side: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 18,
            right: 8,
            bottom: widget.maxLength != null && widget.showCounter ? 10 : 0,
          ),
          child: Center(
            child: Theme(
              data: theme.copyWith(
                inputDecorationTheme: const InputDecorationTheme(),
              ),
              child: TextFormField(
                autocorrect: false,
                autofocus: widget.autoFocus,
                focusNode: widget.focusNode,
                maxLength: widget.maxLength,
                inputFormatters: widget.formatters,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                obscureText: widget.hidden && !isShown,
                cursorColor: theme.primaryColor,
                enabled: widget.enabled,
                minLines: widget.minLines,
                maxLines: widget.maxLines! < widget.minLines!
                    ? widget.minLines
                    : widget.maxLines,
                style: theme.textTheme.headlineSmall!.copyWith(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  counter: widget.showCounter ? null : const SizedBox.shrink(),
                  hintText: widget.hint,
                  hintStyle: widget.hintStyle ??
                      theme.textTheme.bodySmall!
                          .copyWith(color: theme.greyScale400),
                  label: widget.label != null
                      ? Text(
                          widget.label!,
                          style: theme.textTheme.bodySmall!.copyWith(
                              color: widget.labelColor ?? theme.greyScale400),
                        )
                      : null,
                  // isDense: true,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                  ),
                  suffixIcon: !widget.hidden
                      ? widget.trailing
                      : GestureDetector(
                          onTap: () => setState(() => isShown = !isShown),
                          child: Icon(
                            !isShown
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: !isShown
                                ? widget.borderColor ?? theme.greyScale400
                                : theme.primaryColor,
                          ),
                        ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 10,
                  ),
                  prefixIcon: widget.leading,
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                ),
                onTapOutside: widget.onTapOutside,
                onChanged: widget.onChanged,
                validator: widget.validator,
                onSaved: widget.onSave,
                onFieldSubmitted: widget.onFieldSubmitted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
