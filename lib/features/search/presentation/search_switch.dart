import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';

class SearchSwitch extends StatelessWidget {
  final bool showCaptured;
  final void Function() toggleCaptured;
  final double containerWidth = 360.0;
  final double containerHeight = 40.0;

  const SearchSwitch({
    super.key,
    required this.showCaptured,
    required this.toggleCaptured,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
      ),
      child: SizedBox(
        height: containerHeight,
        width: containerWidth,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                border: Border.all(),
                borderRadius: BorderRadius.circular(containerHeight / 2),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: !showCaptured ? 0 : (containerWidth / 2),
              child: Container(
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  color: Palette.yellow,
                  borderRadius: BorderRadius.circular(containerHeight / 2),
                ),
                height: containerHeight - 2,
                width: containerWidth / 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: GestureDetector(
                    onTap: toggleCaptured,
                    child: Container(
                      height: containerHeight,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text(
                        'Pokedex',
                        style: !showCaptured
                            ? AppTextStyle.titleBlack
                            : AppTextStyle.titleWhite,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: GestureDetector(
                    onTap: toggleCaptured,
                    child: Container(
                      height: containerHeight,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text(
                        'Captured',
                        style: showCaptured
                            ? AppTextStyle.titleBlack
                            : AppTextStyle.titleWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: toggleCaptured,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(containerHeight / 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
