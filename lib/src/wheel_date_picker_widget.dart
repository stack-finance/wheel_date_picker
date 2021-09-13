import 'package:flutter/material.dart';
import 'package:wheel_date_picker/src/utils/utils.dart';
import 'package:wheel_date_picker/wheel_date_picker.dart';

class WheelDatePickerSlider extends StatelessWidget {
  WheelDatePickerSlider({
    Key? key,
    required this.config,
    required this.onChanged,
    this.dateContainerHeight = 76,
    this.maxDate = 31,
    this.itemWidth = 164,
    this.textStyle,
    this.subTextStyle,
    this.wheelHeight = 132,
    this.animDuration = const Duration(milliseconds: 200),
    this.secondaryBarCount = 3,
    this.selectorLeftSpacing = 114,
    this.selectorHeight = 200,
    this.selectorWidth = 3,
    this.selectorColor = const Color(0xff4c67e2),
    this.controller,
  })  : assert(itemWidth >= 0),
        assert(maxDate >= 0),
        super(key: key);

  final double dateContainerHeight;

  final TextStyle? textStyle;

  final TextStyle? subTextStyle;

  final double wheelHeight;

  final Duration animDuration;

  final int secondaryBarCount;

  final double selectorLeftSpacing;

  final double selectorHeight;

  final double selectorWidth;

  final Color selectorColor;

  final ScrollController? controller;

  /// Maximum weight that the slider can be scrolled
  final int maxDate;

  /// Pointer configuration
  final PointerConfig config;

  /// Size of each child in the main axis
  final double itemWidth;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<double> onChanged;

  final onChange = ValueNotifier(0);

  final dateController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: dateContainerHeight,
              child: ListView.builder(
                itemCount: maxDate,
                shrinkWrap: true,
                controller: dateController,
                itemBuilder: (_, index) {
                  return Container(
                    height: dateContainerHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text(
                          (index + 1).toString().padLeft(2, '0'),
                          style: textStyle ??
                              TextStyle(
                                fontSize: 76,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff4863e1),
                              ),
                        ),
                        Text(
                          sanitizeDay(index + 1),
                          style: subTextStyle ??
                              TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff4863e1),
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: wheelHeight,
              child: RotatedBox(
                quarterTurns: -1,
                child: Stack(
                  children: [
                    ListWheelScrollView(
                      controller: controller,
                      itemExtent: itemWidth,
                      physics: FixedExtentScrollPhysics(),
                      perspective: 0.00000001,
                      onSelectedItemChanged: (val) {
                        onChange.value = val;
                        dateController.animateTo(
                          val * dateContainerHeight,
                          duration: animDuration,
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      children: [
                        for (var i = 0; i < maxDate; i++) ...{
                          Column(
                            children: [
                              SecondaryPointer(
                                color: config.color,
                                width: config.height,
                                height: config.width,
                              ),
                              if (i != maxDate - 1) ...{
                                for (var i = 0; i < secondaryBarCount; i++) ...{
                                  SizedBox(height: config.gap),
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
                      top: selectorLeftSpacing,
                      child: Container(
                        height: selectorWidth,
                        width: selectorHeight,
                        color: selectorColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
