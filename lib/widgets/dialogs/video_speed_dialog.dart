import 'package:aves/widgets/common/extensions/build_context.dart';
import 'package:flutter/material.dart';

import 'aves_dialog.dart';

class VideoSpeedDialog extends StatefulWidget {
  static const routeName = '/dialog/select_video_speed';

  final double current, min, max;

  const VideoSpeedDialog({
    super.key,
    required this.current,
    required this.min,
    required this.max,
  });

  @override
  State<VideoSpeedDialog> createState() => _VideoSpeedDialogState();
}

class _VideoSpeedDialogState extends State<VideoSpeedDialog> {
  late double _speed;

  static const interval = .25;

  @override
  void initState() {
    super.initState();
    _speed = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return AvesDialog(
      horizontalContentPadding: 4,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Wrap(
              children: [
                Text(context.l10n.videoSpeedDialogLabel),
                const SizedBox(width: 16),
                Text('x$_speed'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Slider(
            value: _speed,
            onChanged: (v) => setState(() => _speed = v),
            min: widget.min,
            max: widget.max,
            divisions: ((widget.max - widget.min) / interval).round(),
          ),
        ],
      ),
      actions: [
        const CancelButton(),
        TextButton(
          onPressed: () => _submit(context),
          child: Text(context.l10n.applyButtonLabel),
        ),
      ],
    );
  }

  void _submit(BuildContext context) => Navigator.maybeOf(context)?.pop(_speed);
}
