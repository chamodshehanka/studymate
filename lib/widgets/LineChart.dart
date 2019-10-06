import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatefulWidget {
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        series: <LineSeries<ChartData, String>>[
          LineSeries<ChartData, String>(
            dataSource: [
              ChartData('Activity Name 1', 5),
              ChartData('Activity Name 1', 10),
              ChartData('Activity Name 1', 15),
              ChartData('Activity Name 1', 25),
            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final int y;
  ChartData(this.x, this.y);
}
