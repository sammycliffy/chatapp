import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speso_chatapp/features/chat/views/widgets/recording_visualiser.dart';
import 'package:speso_chatapp/theme/theme.dart';

import '../../../../theme/color_theme.dart';

class VoiceRecorder extends ConsumerWidget {
  const VoiceRecorder({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = Theme.of(context).custom.colorTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColorsDark.appBarColor
          : AppColorsLight.incomingMessageBubbleColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RecordingVisualiser(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.delete,
                  size: 36,
                ),
              ),
              InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.red),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.pause_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                  )),
              InkWell(
                onTap: () async {},
                child: CircleAvatar(
                  radius: 21,
                  backgroundColor: colorTheme.greenColor,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class VoiceRecorderField extends ConsumerWidget {
  const VoiceRecorderField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = Theme.of(context).custom.colorTheme;
    const showMic = Duration(milliseconds: 500);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Icon(
                      Icons.mic,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  Text(
                    "0:00",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? colorTheme.iconColor
                          : colorTheme.textColor2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Icon(
                      Icons.mic,
                      color: Colors.transparent,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    '2',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? colorTheme.iconColor
                          : colorTheme.textColor2,
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(
            "◀ Slide to cancel",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? colorTheme.iconColor
                  : colorTheme.textColor2,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
