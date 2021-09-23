import 'package:flutter/material.dart';
import 'package:wheel_date_picker/wheel_date_picker.dart';

class WheelDatePickerSlider extends StatelessWidget {
  WheelDatePickerSlider({
    Key? key,
    required this.config,
    required this.onChanged,
    this.dateContainerHeight = 100,
    this.maxDate = 31,
    this.itemWidth = 126,
    this.textStyle,
    this.subTextStyle,
    this.wheelHeight = 131,
    this.animDuration = const Duration(milliseconds: 200),
    this.secondaryBarCount = 3,
    this.selectorLeftSpacing = 116,
    this.selectorHeight = 131,
    this.selectorWidth = 3,
    this.selectorColor = const Color(0xff4c67e2),
    this.controller,
    this.minDate = 0,
  })  : assert(itemWidth >= 0),
        assert(maxDate >= 0),
        assert(minDate >= 0),
        super(key: key);

  final int dateContainerHeight;

  final TextStyle? textStyle;

  final TextStyle? subTextStyle;

  final int wheelHeight;

  final Duration animDuration;

  final int secondaryBarCount;

  final int selectorLeftSpacing;

  final int selectorHeight;

  final int selectorWidth;

  final Color selectorColor;

  final ScrollController? controller;

  /// Maximum weight that the slider can be scrolled
  final int maxDate;

  ///
  /// Minimum date that slider can be scrolled minimum
  /// eg. if min date is 12 set min date to 11
  ///
  final int minDate;

  /// Pointer configuration
  final PointerConfig config;

  /// Size of each child in the main axis
  final int itemWidth;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<int> onChanged;

  final onChange = ValueNotifier(0);

  final dateController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: dateContainerHeight.h,
            child: ListView.builder(
              itemCount: maxDate - minDate,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              controller: dateController,
              itemBuilder: (_, index) {
                return Container(
                  height: dateContainerHeight.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Text(
                        (index + minDate + 1).toString().padLeft(2, '0'),
                        style: textStyle ??
                            TextStyle(
                              fontSize: 76,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff4863e1),
                            ),
                      ),
                      Text(
                        sanitizeDay(index + minDate + 1),
                        style: subTextStyle ??
                            TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff4863e1),
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: wheelHeight.h,
            child: RotatedBox(
              quarterTurns: -1,
              child: Stack(
                children: [
                  ListWheelScrollView(
                    controller: controller,
                    itemExtent: itemWidth.w,
                    physics: FixedExtentScrollPhysics(),
                    perspective: 0.00000001,
                    onSelectedItemChanged: (val) {
                      onChange.value = val;
                      onChanged.call(val + 1);
                      dateController.animateTo(
                        val * dateContainerHeight.h,
                        duration: animDuration,
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    children: [
                      for (var i = 0; i < maxDate - minDate; i++) ...{
                        Column(
                          children: [
                            SecondaryPointer(
                              color: config.color,
                              width: config.height,
                              height: config.width,
                            ),
                            if (i != maxDate - minDate - 1) ...{
                              for (var i = 0; i < secondaryBarCount; i++) ...{
                                SizedBox(height: config.gap.w),
                                SecondaryPointer(
                                  color: config.color,
                                  width: config.secondaryHeight,
                                  height: config.width,
                                ),
                              },
                            }
                          ],
                        )
                      }
                    ],
                  ),
                  Positioned(
                    top: selectorLeftSpacing.w,
                    child: Container(
                      height: selectorWidth.w,
                      width: selectorHeight.h,
                      color: selectorColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
