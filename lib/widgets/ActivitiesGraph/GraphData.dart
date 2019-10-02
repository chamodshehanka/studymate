class GraphData implements Comparable<GraphData> {
  String label;
  int value;

  GraphData(this.label, this.value);

  @override
  int compareTo(GraphData other) {
    return this.value.compareTo(other.value);
  }
}

List<GraphData> dayData = [
  GraphData('12AM', 100),
  GraphData('3AM', 10),
  GraphData('6AM', 180),
  GraphData('9AM', 100),
  GraphData('12AM', 100),
  GraphData('3PM', 90),
  GraphData('6PM', 160),
  GraphData('9PM', 50),
  GraphData('12PM', 80)
];

List<GraphData> weekData = [
  GraphData('Sunday', 9000),
  GraphData('Monday', 1800),
  GraphData('Tuesday', 1900),
  GraphData('WednesDay', 1300),
  GraphData('Thursday', 1500),
  GraphData('Friday', 3500),
  GraphData('Saturday', 4000),
];

List<GraphData> monthDay = [
  GraphData('01', 2000),
  GraphData('02', 500),
  GraphData('03', 320),
];
