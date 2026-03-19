import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

/// A simplified decorative map of Europe rendered with [CustomPainter].
///
/// Highlights the country matching [countryCode] (ISO 3166-1 alpha-2)
/// in the theme's accent color; other countries are drawn in a muted tone.
class EuropeMap extends StatelessWidget {
  const EuropeMap({required this.countryCode, super.key});

  final String countryCode;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.1,
        child: CustomPaint(
          painter: _EuropeMapPainter(
            highlightCode: countryCode.toUpperCase(),
            accentColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
}

class _EuropeMapPainter extends CustomPainter {
  _EuropeMapPainter({
    required this.highlightCode,
    required this.accentColor,
  });

  final String highlightCode;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 500;
    final sy = size.height / 450;

    final mutedPaint = Paint()
      ..color = ColorName.surfaceBorder
      ..style = PaintingStyle.fill;

    final highlightPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = ColorName.surfaceLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (final entry in _countries.entries) {
      final paint =
          entry.key == highlightCode ? highlightPaint : mutedPaint;
      final path = _buildPath(entry.value, sx, sy);
      canvas
        ..drawPath(path, paint)
        ..drawPath(path, borderPaint);
    }
  }

  Path _buildPath(List<List<double>> points, double sx, double sy) {
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = points[i][0] * sx;
      final y = points[i][1] * sy;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_EuropeMapPainter oldDelegate) =>
      highlightCode != oldDelegate.highlightCode ||
      accentColor != oldDelegate.accentColor;

  // Simplified polygon data for European countries.
  // Coordinates are in a 500x450 virtual canvas.
  static const _countries = <String, List<List<double>>>{
    'IS': [
      [55, 25], [90, 15], [115, 20], [120, 35], [105, 50],
      [75, 55], [50, 45],
    ],
    'NO': [
      [195, 10], [210, 5], [230, 15], [240, 45], [235, 80],
      [225, 110], [215, 130], [205, 140], [195, 130], [200, 100],
      [205, 70], [200, 40],
    ],
    'SE': [
      [235, 80], [250, 60], [265, 55], [270, 75], [265, 110],
      [255, 140], [240, 160], [225, 155], [215, 130], [225, 110],
    ],
    'FI': [
      [270, 35], [290, 30], [305, 45], [310, 75], [305, 105],
      [295, 130], [280, 140], [265, 130], [265, 110], [270, 75],
    ],
    'EE': [
      [295, 130], [320, 128], [322, 142], [296, 144],
    ],
    'LV': [
      [296, 144], [322, 142], [324, 158], [298, 160],
    ],
    'LT': [
      [298, 160], [324, 158], [325, 178], [300, 180],
    ],
    'DK': [
      [225, 140], [240, 135], [245, 145], [240, 160], [230, 165],
      [220, 158],
    ],
    'GB': [
      [145, 120], [165, 110], [175, 120], [178, 145], [172, 175],
      [160, 185], [148, 175], [140, 150],
    ],
    'IE': [
      [120, 130], [140, 125], [145, 145], [140, 165], [125, 170],
      [115, 155],
    ],
    'NL': [
      [210, 170], [225, 168], [228, 182], [215, 188], [208, 180],
    ],
    'BE': [
      [200, 190], [218, 188], [220, 200], [208, 205], [198, 198],
    ],
    'LU': [
      [208, 205], [215, 203], [216, 212], [209, 213],
    ],
    'DE': [
      [228, 158], [250, 155], [265, 165], [270, 190], [265, 215],
      [255, 230], [235, 235], [220, 225], [215, 210], [218, 195],
      [225, 180], [225, 168],
    ],
    'PL': [
      [270, 165], [300, 160], [325, 178], [330, 200], [320, 220],
      [300, 230], [280, 225], [265, 215], [270, 190],
    ],
    'CZ': [
      [255, 220], [280, 218], [285, 232], [270, 240], [252, 235],
    ],
    'SK': [
      [285, 232], [310, 228], [318, 240], [300, 245], [285, 242],
    ],
    'FR': [
      [160, 195], [185, 185], [200, 195], [210, 215], [215, 245],
      [205, 270], [185, 285], [165, 280], [150, 260], [145, 235],
      [150, 210],
    ],
    'CH': [
      [215, 248], [235, 245], [240, 255], [228, 262], [213, 258],
    ],
    'AT': [
      [245, 240], [275, 238], [285, 248], [275, 258], [255, 260],
      [240, 255],
    ],
    'HU': [
      [290, 248], [320, 245], [330, 258], [320, 270], [298, 272],
      [285, 262],
    ],
    'RO': [
      [330, 250], [360, 245], [380, 260], [378, 280], [360, 290],
      [340, 285], [325, 275],
    ],
    'BG': [
      [345, 295], [370, 290], [382, 300], [378, 315], [360, 320],
      [342, 312],
    ],
    'MD': [
      [365, 235], [380, 232], [385, 250], [375, 255], [362, 248],
    ],
    'UA': [
      [330, 195], [365, 185], [400, 190], [430, 200], [440, 220],
      [425, 245], [400, 255], [380, 255], [365, 245], [340, 245],
      [330, 230], [325, 210],
    ],
    'BY': [
      [325, 155], [355, 150], [370, 165], [365, 185], [340, 190],
      [325, 185], [320, 170],
    ],
    'IT': [
      [228, 268], [245, 262], [255, 275], [265, 300], [270, 330],
      [260, 350], [248, 355], [240, 340], [242, 315], [235, 295],
      [225, 280],
    ],
    'SI': [
      [268, 260], [282, 258], [285, 268], [275, 272], [265, 270],
    ],
    'HR': [
      [275, 272], [290, 268], [305, 278], [310, 295], [300, 310],
      [288, 300], [280, 285], [272, 276],
    ],
    'BA': [
      [295, 285], [308, 280], [315, 295], [305, 310], [292, 305],
    ],
    'RS': [
      [315, 275], [332, 272], [340, 290], [335, 310], [320, 315],
      [310, 300],
    ],
    'ME': [
      [310, 310], [322, 308], [325, 320], [315, 325], [305, 318],
    ],
    'XK': [
      [325, 315], [338, 312], [340, 325], [330, 328], [322, 322],
    ],
    'AL': [
      [322, 325], [335, 322], [338, 345], [328, 355], [318, 345],
    ],
    'MK': [
      [340, 315], [358, 312], [360, 325], [348, 330], [338, 325],
    ],
    'GR': [
      [335, 340], [355, 330], [370, 340], [375, 365], [365, 385],
      [350, 395], [335, 385], [330, 365],
    ],
    'TR': [
      [385, 305], [420, 295], [460, 300], [480, 315], [475, 335],
      [450, 340], [420, 335], [395, 325], [382, 315],
    ],
    'PT': [
      [125, 280], [140, 275], [145, 300], [142, 330], [135, 345],
      [122, 340], [118, 310],
    ],
    'ES': [
      [140, 275], [175, 265], [195, 275], [200, 300], [195, 325],
      [180, 345], [155, 350], [140, 340], [142, 310], [145, 290],
    ],
    'RU': [
      [370, 30], [420, 10], [470, 20], [490, 50], [485, 100],
      [475, 140], [460, 170], [440, 195], [420, 195], [400, 190],
      [380, 180], [370, 165], [360, 145], [340, 140], [320, 135],
      [310, 120], [315, 90], [330, 60], [350, 40],
    ],
  };
}
