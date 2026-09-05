import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet {
  const AppBottomSheet._();

  static Future<T?> show<T>({
    required WidgetBuilder builder,
    required BuildContext context,

    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,

    Color? barrierColor,
    String? barrierLabel,

    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    bool requestFocus = true,

    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
  }) => showModalBottomSheet<T>(
    context: context,

    backgroundColor:  Colors.transparent,
    elevation: elevation ?? 14,
    shape: shape,
    clipBehavior: clipBehavior,
    constraints:
        constraints ??
        BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .85),

    barrierColor: barrierColor ?? Colors.black45,
    barrierLabel: barrierLabel,

    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    showDragHandle: showDragHandle,
    useSafeArea: useSafeArea,
    requestFocus: requestFocus,

    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    anchorPoint: anchorPoint,
    sheetAnimationStyle:
        sheetAnimationStyle ??
        const AnimationStyle(
          duration: Duration(milliseconds: 350),
          reverseDuration: Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        ),

    builder: (sheetContext) => _KeyboardAware(backgroundColor: backgroundColor, child: builder(sheetContext)),
  );
}

class _KeyboardAware extends StatelessWidget {
  const _KeyboardAware({required this.child, this.backgroundColor});

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: bottomInset),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          color: backgroundColor ?? Theme.of(context).colorScheme.onSecondary,
        ),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
