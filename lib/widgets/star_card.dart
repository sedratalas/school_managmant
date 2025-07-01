import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StatCardPainter extends CustomPainter {
  final Color cardColor;
  final Color curveAccentColor;

  StatCardPainter({required this.cardColor, required this.curveAccentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(15),
    );
    final cardPaint = Paint()..color = cardColor;
    canvas.drawRRect(rRect, cardPaint);

    final wavePaint = Paint()
      ..color = curveAccentColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);

    path.cubicTo(
      size.width * 0.25, size.height * 0.7,
      size.width * 0.25, size.height * 0.9,
      size.width * 0.5, size.height * 0.8,
    );

    path.cubicTo(
      size.width * 0.75, size.height * 0.7,
      size.width * 0.75, size.height * 0.9,
      size.width, size.height * 0.8,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant StatCardPainter oldDelegate) {
    return oldDelegate.cardColor != cardColor || oldDelegate.curveAccentColor != curveAccentColor;
  }
}

class StatCardWidget extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final VoidCallback onTap;
  final bool isLoading;

  const StatCardWidget({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardBackgroundColor = color.withOpacity(0.8);
    final Color waveAccentColor = Colors.black.withOpacity(0.1);

    return GestureDetector(
      onTap: onTap,
      child: isLoading
          ? Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 120,
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      )
          : Container(
        height: 120,
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: StatCardPainter(
                    cardColor: cardBackgroundColor,
                    curveAccentColor: waveAccentColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9))),
                    const SizedBox(height: 8),
                    Text(count.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
