import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speso_chatapp/theme/theme.dart';

class ScrollButton extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const ScrollButton({super.key, required this.scrollController});

  @override
  ConsumerState<ScrollButton> createState() => _ScrollButtonState();
}

class _ScrollButtonState extends ConsumerState<ScrollButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleScrollBtnClick,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).custom.colorTheme.appBarColor,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black38,
                )
              ],
            ),
            child: const Icon(Icons.keyboard_double_arrow_down),
          ),
          ...[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).custom.colorTheme.greenColor,
                shape: BoxShape.circle,
              ),
              child: const Text(
                "Test",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(scrollListener);
    super.dispose();
  }

  void handleScrollBtnClick() {
    widget.scrollController.animateTo(
      widget.scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void initState() {
    widget.scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    final position = widget.scrollController.position;
    final diff = position.pixels - position.minScrollExtent;
    const showScrollBtn = null;

    if (showScrollBtn && diff > 80) {
      return;
    }

    if (showScrollBtn && diff <= 80) {
      return;
    }

    if (showScrollBtn || diff <= 80) return;
  }
}
