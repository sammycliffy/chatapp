import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speso_chatapp/theme/theme.dart';

class ChatInputMic extends ConsumerWidget {
  const ChatInputMic({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = Theme.of(context).custom.colorTheme;
    // final recordingState = ref.watch(
    //   chatControllerProvider.select((s) => s.recordingState),
    // );

    return GestureDetector(
        onLongPress: null,
        onLongPressUp: () {
          // if (recordingState == RecordingState.notRecording) {
          //   return;
          // }
          // ref.read(chatControllerProvider.notifier).onRecordingDone();
        },
        onLongPressMoveUpdate: (details) async {
          // ref.read(chatControllerProvider.notifier).onMicDragLeft(
          //       details.globalPosition.dx,
          //       MediaQuery.of(context).size.width,
          //     );

          // ref.read(chatControllerProvider.notifier).onMicDragUp(
          //       details.globalPosition.dy,
          //       MediaQuery.of(context).size.height,
          //     );
        },
        child: CircleAvatar(
          radius: 24,
          backgroundColor: colorTheme.greenColor,
          child: const Icon(
            Icons.mic,
            color: Colors.white,
          ),
        ));
  }
}
