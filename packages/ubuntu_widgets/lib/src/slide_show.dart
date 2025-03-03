import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kButtonColor = Colors.white;
const _kButtonSize = 80.0;

const _kIconColor = Colors.black87;
const _kIconSize = 48.0;

/// The default curve for slide transitions.
const kSlideCurve = Curves.easeInOut;

/// The default duration for slide transitions.
const kSlideDuration = Duration(milliseconds: 250);

/// The default interval for automatic slide changes.
const kSlideInterval = Duration(seconds: 15);

/// Displays a set of slides, or any widgets, that animate in and out at a
/// specified interval. The slides can be manually navigated by pressing arrow
/// buttons on the sides, too.
class SlideShow extends StatefulWidget {
  /// Creates a slide show with the given slides and interval.
  SlideShow({
    super.key,
    required this.slides,
    this.curve = kSlideCurve,
    this.duration = kSlideDuration,
    this.interval = kSlideInterval,
    this.wrap = false,
    this.autofocus = false,
    this.focusNode,
    this.onSlide,
  }) : assert(slides.isNotEmpty);

  /// The list of slides to show.
  final List<Widget> slides;

  /// The curve for slide transitions. Defaults to [kSlideCurve].
  final Curve curve;

  /// The duration for slide transitions. Defaults to [kSlideDuration].
  final Duration duration;

  /// The interval for automatic slide changes. Defaults to [kSlideInterval].
  final Duration interval;

  /// Whether to wrap around. The default value is false.
  final bool wrap;

  /// Whether to automatically request keyboard focus.
  final bool autofocus;

  /// Defines the keyboard focus for the slide show.
  final FocusNode? focusNode;

  /// Called when the current slide changes.
  final ValueChanged<int>? onSlide;

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final _controller = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    restartTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void restartTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.interval, (_) => animateToNextSlide());
  }

  int get slideCount => widget.slides.length;
  int get currentSlide => currentPosition.round();

  double get currentPosition =>
      _controller.hasClients ? _controller.page ?? 0 : 0;

  double clampOpacity(double position) {
    if (widget.wrap) return 1.0;
    return position.clamp(0.0, 1.0);
  }

  void animateToSlide(int slide) {
    restartTimer();
    _controller.animateToPage(
      slide,
      curve: widget.curve,
      duration: widget.duration,
    );
    widget.onSlide?.call(slide);
  }

  void animateToNextSlide() {
    final nextSlide = currentSlide + 1;
    if (widget.wrap) {
      animateToSlide(nextSlide % slideCount);
    } else if (nextSlide < slideCount) {
      animateToSlide(nextSlide);
    }
  }

  void animateToPreviousSlide() {
    final previousSlide = currentSlide - 1;
    if (previousSlide >= 0 || widget.wrap) {
      animateToSlide(previousSlide >= 0 ? previousSlide : slideCount - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft):
            animateToPreviousSlide,
        const SingleActivator(LogicalKeyboardKey.arrowRight):
            animateToNextSlide,
      },
      child: Focus(
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        child: Stack(
          children: <Widget>[
            // PageView doesn't propagate its content's size. Use the first slide
            // to determine the size.
            Opacity(opacity: 0, child: widget.slides.first),
            Positioned.fill(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: widget.slides,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: -_kButtonSize / 2,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return _SlideButton(
                    alignment: Alignment.centerRight,
                    icon: const Icon(Icons.chevron_left, size: _kIconSize),
                    opacity: clampOpacity(currentPosition),
                    onPressed: animateToPreviousSlide,
                  );
                },
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: -_kButtonSize / 2,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return _SlideButton(
                    alignment: Alignment.centerLeft,
                    icon: const Icon(Icons.chevron_right, size: _kIconSize),
                    opacity: clampOpacity((slideCount - 1 - currentPosition)),
                    onPressed: animateToNextSlide,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideButton extends StatelessWidget {
  const _SlideButton({
    required this.icon,
    required this.alignment,
    required this.opacity,
    required this.onPressed,
  });

  final Widget icon;
  final Alignment alignment;
  final double opacity;
  final VoidCallback? onPressed;

  bool get enabled => opacity > 0.5;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: Material(
          elevation: 10,
          color: _kButtonColor,
          type: MaterialType.circle,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: _kButtonSize,
            height: _kButtonSize,
            child: opacity > 0
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: alignment,
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: _kButtonColor,
                      foregroundColor: _kIconColor,
                    ),
                    onPressed: onPressed,
                    child: icon,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
