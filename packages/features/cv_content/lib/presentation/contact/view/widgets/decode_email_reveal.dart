import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<_CharState> _chars = [];
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
        (_) => _CharState(
          char: _randomGlyph(),
          opacity: _randomOpacity(),
        ),
      );
    });

    _scrambleTimer = Timer.periodic(_scrambleInterval, (_) {
      if (!mounted) return;
      setState(() {
        for (var i = _revealedCount; i < _chars.length; i++) {
          _chars[i] = _CharState(
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
      child: Center(child: _buildContent(accentColor, textTheme, fixedStyle)),
    );
  }

  static const _charWidth = 10.0;
  static const _charHeight = 24.0;

  Widget _buildContent(
    Color accentColor,
    TextTheme textTheme,
    TextStyle? baseStyle,
  ) {
    if (_revealed) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () =>
              unawaited(launchUrl(Uri.parse('mailto:${widget.email}'))),
          child: _emailRow(
            accentColor: accentColor,
            cells: _buildCharCells(
              widget.email,
              List.filled(
                widget.email.length,
                baseStyle?.copyWith(color: ColorName.textPrimary),
              ),
            ),
          ),
        ),
      );
    }

    if (_revealing) {
      final styles = <TextStyle?>[
        for (var i = 0; i < _chars.length; i++)
          if (i < _revealedCount)
            baseStyle?.copyWith(color: ColorName.textPrimary)
          else
            baseStyle?.copyWith(
              color: accentColor.withValues(alpha: _chars[i].opacity),
            ),
      ];

      final text = StringBuffer();
      for (var i = 0; i < _chars.length; i++) {
        text.write(i < _revealedCount ? widget.email[i] : _chars[i].char);
      }

      return _emailRow(
        accentColor: accentColor,
        cells: _buildCharCells(text.toString(), styles),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _startReveal,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: accentColor.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline,
                size: AppDimensions.iconSizeDefault,
                color: accentColor,
              ),
              const SizedBox(width: AppDimensions.spacingSmall),
              Text(
                'Reveal Email',
                style: textTheme.bodyMedium?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailRow({
    required Color accentColor,
    required List<Widget> cells,
  }) =>
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.email_outlined,
              size: AppDimensions.iconSizeMedium,
              color: accentColor,
            ),
            const SizedBox(width: 12),
            ...cells,
          ],
        ),
      );

  List<Widget> _buildCharCells(String text, List<TextStyle?> styles) => [
        for (var i = 0; i < text.length; i++)
          SizedBox(
            width: _charWidth,
            height: _charHeight,
            child: Center(
              child: Text(
                text[i],
                style: styles[i],
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ];
}

class _CharState {
  _CharState({required this.char, required this.opacity});

  final String char;
  final double opacity;
}
