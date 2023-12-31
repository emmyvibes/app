import 'package:flutter/material.dart';

class MultiCrossFader extends StatefulWidget {
  final Duration duration;
  final Curve fadeCurve, sizeCurve;
  final AlignmentGeometry alignment;
  final AnimatedCrossFadeBuilder layoutBuilder;
  final Widget child;

  const MultiCrossFader({
    super.key,
    required this.duration,
    this.fadeCurve = Curves.linear,
    this.sizeCurve = Curves.linear,
    this.alignment = Alignment.topCenter,
    this.layoutBuilder = AnimatedCrossFade.defaultLayoutBuilder,
    required this.child,
  });

  @override
  State<MultiCrossFader> createState() => _MultiCrossFaderState();
}

class _MultiCrossFaderState extends State<MultiCrossFader> {
  late Widget _first, _second;
  CrossFadeState _fadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
    _first = widget.child;
    _second = const SizedBox();
  }

  @override
  void didUpdateWidget(covariant MultiCrossFader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child == _first) {
      _second = widget.child;
      _fadeState = CrossFadeState.showSecond;
    } else {
      _first = widget.child;
      _fadeState = CrossFadeState.showFirst;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: _first,
      secondChild: _second,
      firstCurve: widget.fadeCurve,
      secondCurve: widget.fadeCurve,
      sizeCurve: widget.sizeCurve,
      alignment: widget.alignment,
      crossFadeState: _fadeState,
      duration: widget.duration,
      reverseDuration: widget.duration,
      layoutBuilder: widget.layoutBuilder,
    );
  }
}
