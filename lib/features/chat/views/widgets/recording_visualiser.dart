import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speso_chatapp/features/chat/views/widgets/painters.dart';

import '../../../../shared/utils/abc.dart';

class RecordingVisualiser extends ConsumerStatefulWidget {
  const RecordingVisualiser({
    super.key,
  });

  @override
  ConsumerState<RecordingVisualiser> createState() =>
      _RecordingVisualiserState();
}

class _RecordingVisualiserState extends ConsumerState<RecordingVisualiser> {
  static const maxHeight = 24.0;
  final List<double> samples = [];

  @override
  Widget build(BuildContext context) {
    final liveWaveColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.black54;

    const data = null;
    final duration = data.last.duration;
    samples.add(data.last.decibels ?? 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            timeFromSeconds(
              duration.inSeconds,
              true,
            ),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxSampleCount = constraints.maxWidth ~/ 5;

              return CustomPaint(
                painter: WaveformPainter(
                  maxHeight: maxHeight,
                  waveColor: liveWaveColor,
                  reverse: true,
                  samples: samples
                      .getRange(
                        samples.length > maxSampleCount
                            ? samples.length - maxSampleCount
                            : 0,
                        samples.length,
                      )
                      .toList(),
                ),
                size: Size(constraints.maxWidth, maxHeight),
              );
            },
          ),
        ),
      ],
    );
  }
}
