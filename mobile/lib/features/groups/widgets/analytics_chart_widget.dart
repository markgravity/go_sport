import 'package:flutter/material.dart';
import '../models/invitation_analytics.dart';

class AnalyticsChart extends StatelessWidget {
  final String title;
  final Map<String, List<DailyActivity>> data;
  final double height;

  const AnalyticsChart({
    Key? key,
    required this.title,
    required this.data,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _buildEmptyChart(context);
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Container(
              height: height,
              child: _buildBarChart(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyChart(BuildContext context) {
    return Card(
      child: Container(
        height: height + 60,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 48,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Chưa có dữ liệu biểu đồ',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(BuildContext context) {
    // Simple bar chart implementation
    final sortedDates = data.keys.toList()..sort();
    if (sortedDates.isEmpty) return Container();

    final maxCount = _getMaxCount();
    if (maxCount == 0) return _buildEmptyChart(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: sortedDates.map((date) => _buildBar(
          context,
          date,
          data[date] ?? [],
          maxCount,
        )).toList(),
      ),
    );
  }

  Widget _buildBar(
    BuildContext context,
    String date,
    List<DailyActivity> activities,
    int maxCount,
  ) {
    final theme = Theme.of(context);
    final totalCount = activities.fold(0, (sum, activity) => sum + activity.count);
    final barHeight = maxCount > 0 ? (totalCount / maxCount) * (height - 40) : 0.0;
    
    // Parse date for display
    final dateLabel = _formatDateLabel(date);

    return Container(
      width: 60,
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Value label
          if (totalCount > 0) ...[
            Text(
              totalCount.toString(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
          ],
          
          // Bar
          Container(
            height: barHeight.clamp(4.0, height - 40),
            decoration: BoxDecoration(
              color: _getBarColor(activities, theme.primaryColor),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
          ),
          
          SizedBox(height: 8),
          
          // Date label
          Text(
            dateLabel,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  String _formatDateLabel(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}';
    } catch (e) {
      return dateString.split('-').last; // Return day part if parsing fails
    }
  }

  Color _getBarColor(List<DailyActivity> activities, Color defaultColor) {
    if (activities.isEmpty) return defaultColor.withOpacity(0.3);
    
    // Color based on event type mix
    final hasClicks = activities.any((a) => a.eventType == 'clicked');
    final hasJoins = activities.any((a) => a.eventType == 'joined');
    
    if (hasJoins) return Colors.green;
    if (hasClicks) return Colors.blue;
    return defaultColor;
  }

  int _getMaxCount() {
    int max = 0;
    for (final activities in data.values) {
      final count = activities.fold(0, (sum, activity) => sum + activity.count);
      if (count > max) max = count;
    }
    return max;
  }
}

class SimpleLineChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final String title;
  final Color? color;
  final double height;

  const SimpleLineChart({
    Key? key,
    required this.values,
    required this.labels,
    required this.title,
    this.color,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lineColor = color ?? theme.primaryColor;

    if (values.isEmpty) {
      return Card(
        child: Container(
          height: height + 60,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.show_chart,
                size: 48,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'Chưa có dữ liệu đồ thị',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Container(
              height: height,
              child: CustomPaint(
                size: Size.infinite,
                painter: _LineChartPainter(
                  values: values,
                  labels: labels,
                  color: lineColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> values;
  final List<String> labels;
  final Color color;

  _LineChartPainter({
    required this.values,
    required this.labels,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final minValue = values.reduce((a, b) => a < b ? a : b);
    final valueRange = maxValue - minValue;

    if (valueRange == 0) return; // All values are the same

    final path = Path();
    final fillPath = Path();
    
    for (int i = 0; i < values.length; i++) {
      final x = (i / (values.length - 1)) * size.width;
      final y = size.height - ((values[i] - minValue) / valueRange) * size.height;
      
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
      
      // Draw point
      canvas.drawCircle(Offset(x, y), 3, pointPaint);
    }

    // Complete fill path
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Draw fill and line
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}