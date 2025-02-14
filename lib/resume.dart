import 'dart:ui';
import 'package:flutter/material.dart';

class ResumeDisplay extends StatelessWidget {
  final String name;
  final String contact;
  final String summary;
  final String experience;
  final String education;
  final String skills;

  const ResumeDisplay({
    super.key,
    required this.name,
    required this.contact,
    required this.summary,
    required this.experience,
    required this.education,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currículum'),
        backgroundColor:
            Colors.lightBlue.withOpacity(0.1), // Set the background color
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: CustomPaint(
            size:
                const Size(double.infinity, 1200), // Large canvas for scrolling
            painter: ResumePainter(
                name, contact, summary, experience, education, skills),
          ),
        ),
      ),
    );
  }
}

class ResumePainter extends CustomPainter {
  final String name, contact, summary, experience, education, skills;

  ResumePainter(
    this.name,
    this.contact,
    this.summary,
    this.experience,
    this.education,
    this.skills,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.lightBlue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    // Column layout
    final double column1Width = size.width * 0.25;
    final double column2Width = size.width - column1Width - 40;
    const double titleHeight = 80.0;
    const double startY = titleHeight + 20;
    const double padding = 20.0;

    // Title Blue Background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, titleHeight),
      backgroundPaint,
    );

    // ColumnBlue Background
    canvas.drawRect(
      Rect.fromLTWH(0, titleHeight, column1Width, size.height - titleHeight),
      backgroundPaint,
    );

    // Draw centered title
    _drawCenteredText(canvas, name, size.width / 2, 30,
        fontSize: 26, isBold: true);

    // Draw horizontal separator
    final Path horizontalPath = Path();
    horizontalPath.moveTo(0, titleHeight);
    horizontalPath.relativeQuadraticBezierTo(
        column1Width / 4, 15, column1Width / 2, 0);
    horizontalPath.relativeQuadraticBezierTo(
        column1Width / 4, -15, column1Width / 2, 0);
    horizontalPath.lineTo(size.width, titleHeight);
    canvas.drawPath(horizontalPath, linePaint);

    // Draw vertical wavy separator
    final Path verticalPath = Path();
    verticalPath.moveTo(column1Width, titleHeight);
    final double waveHeight = (size.height - titleHeight) / 6;

    for (int i = 0; i < 6; i++) {
      verticalPath.relativeQuadraticBezierTo(
          15 * (i.isEven ? 1 : -1), waveHeight / 2, 0, waveHeight);
    }

    canvas.drawPath(verticalPath, linePaint);

    // Draw sections
    double currentPosition = startY;
    currentPosition = _drawSection(canvas, 'Dades cont.', contact,
        currentPosition, column1Width, column2Width, padding, size);
    currentPosition = _drawSection(canvas, 'Resum', summary, currentPosition,
        column1Width, column2Width, padding, size);
    currentPosition = _drawSection(canvas, 'Exp. lab.', experience,
        currentPosition, column1Width, column2Width, padding, size);
    currentPosition = _drawSection(canvas, 'Formació', education,
        currentPosition, column1Width, column2Width, padding, size);
    _drawSection(canvas, 'Aptituds', skills, currentPosition, column1Width,
        column2Width, padding, size);
  }

  // Centered text
  void _drawCenteredText(Canvas canvas, String text, double centerX, double y,
      {double fontSize = 14, bool isBold = false}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final double x = centerX - (textPainter.width / 2); // Centering logic
    textPainter.paint(canvas, Offset(x, y));
  }

  // Draw a section with aligned titles and limited separator
  double _drawSection(Canvas canvas, String title, String content, double y,
      double col1Width, double col2Width, double padding, Size size) {
    const double sectionSpacing = 10.0;

    // Measure title width
    final TextPainter titlePainter = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
    );

    titlePainter.layout(maxWidth: col1Width - 2 * padding);
    final double titleX =
        col1Width - titlePainter.width - padding; // Align to the right
    titlePainter.paint(canvas, Offset(titleX, y));

    // Draw section content
    final double textWidth = col2Width - (2 * padding);
    final double textHeight = _drawText(
      canvas,
      content,
      Offset(col1Width + padding, y),
      fontSize: 14,
      maxWidth: textWidth,
    );

    // Row separator only occupies 80% of the text column
    final double separatorStart = col1Width + padding;
    final double separatorEnd = separatorStart + (textWidth * 0.8);
    canvas.drawLine(
      Offset(separatorStart, y + textHeight + sectionSpacing),
      Offset(separatorEnd, y + textHeight + sectionSpacing),
      Paint()
        ..color = Colors.black.withOpacity(0.3)
        ..strokeWidth = 1,
    );

    return y + textHeight + sectionSpacing + 15;
  }

  /// Draw text with wrapping support
  double _drawText(Canvas canvas, String text, Offset position,
      {double fontSize = 14,
      bool isBold = false,
      double maxWidth = double.infinity}) {
    final TextSpan span = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );

    final TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: maxWidth == double.infinity ? null : 10,
      ellipsis: '...',
    );

    textPainter.layout(maxWidth: maxWidth);
    textPainter.paint(canvas, position);
    return textPainter.height;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
