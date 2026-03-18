import 'dart:async';
import 'dart:math';

import 'package:cv_content/presentation/contact/view/widgets/email_reveal_content.dart';
import 'package:flutter/material.dart';

class DecodeEmailReveal extends StatefulWidget {
  const DecodeEmailReveal({required this.email, super.key});

  final String email;

  @override
  State<DecodeEmailReveal> createState() => _DecodeEmailRevealState();
}

class _DecodeEmailRevealState extends State<DecodeEmailReveal> {
  // Same character set as matrix rain
  static const _glyphs = 'アイウエオカキクケコサシスセソタチツテト'
      'ナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン'
      '0123456789ABCDEF';
  static const _scrambleInterval = Duration(milliseconds: 30);
  static const _revealInterval = Duration(milliseconds: 60);

  /// Tracks revealed emails for the current session.
  static final _revealedEmails = <String>{};

  final _random = Random();
  var _revealed = false;
  var _revealing = false;
  var _revealedCount = 0;
  List<CharState> _chars = [];
  Timer? _scrambleTimer;
  Timer? _revealTimer;

  @override
  void initState() {
    super.initState();
    _revealed = _revealedEmails.contains(widget.email);
  }

  @override
  void dispose() {
    _scrambleTimer?.cancel();
    _revealTimer?.cancel();
    super.dispose();
  }

  void _startReveal() {
    if (_revealing || _revealed) return;
    setState(() {
      _revealing = true;
      _chars = List.generate(
        widget.email.length,
        (_) => CharState(
          char: _randomGlyph(),
          opacity: _randomOpacity(),
        ),
      );
    });

    _scrambleTimer = Timer.periodic(_scrambleInterval, (_) {
      if (!mounted) return;
      setState(() {
        for (var i = _revealedCount; i < _chars.length; i++) {
          _chars[i] = CharState(
            char: _randomGlyph(),
            opacity: _randomOpacity(),
          );
        }
      });
    });

    _revealTimer = Timer.periodic(_revealInterval, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _revealedCount++;
        if (_revealedCount >= widget.email.length) {
          _scrambleTimer?.cancel();
          _revealTimer?.cancel();
          _revealed = true;
          _revealing = false;
          _revealedEmails.add(widget.email);
        }
      });
    });
  }

  String _randomGlyph() =>
      String.fromCharCode(_glyphs.codeUnitAt(_random.nextInt(_glyphs.length)));

  double _randomOpacity() => 0.3 + _random.nextDouble() * 0.5;

  static const _fixedHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.primary;
    final textTheme = Theme.of(context).textTheme;
    final baseStyle = textTheme.titleMedium;

    final fixedStyle = baseStyle?.copyWith(
      height: 1,
      letterSpacing: 0.5,
    );

    return SizedBox(
      height: _fixedHeight,
      child: Center(
        child: EmailRevealContent(
          email: widget.email,
          revealed: _revealed,
          revealing: _revealing,
          revealedCount: _revealedCount,
          chars: _chars,
          accentColor: accentColor,
          textTheme: textTheme,
          baseStyle: fixedStyle,
          onReveal: _startReveal,
        ),
      ),
    );
  }
}
