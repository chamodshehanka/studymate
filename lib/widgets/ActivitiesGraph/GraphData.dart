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

List<GraphData> monthData = [
  GraphData("01", 200),
  GraphData("02", 500),
  GraphData("03", 320),
  GraphData("04", 490),
  GraphData("05", 450),
  GraphData("06", 600),
  GraphData("07", 650),
  GraphData("08", 700),
  GraphData("09", 670),
  GraphData("10", 350),
  GraphData("11", 420),
  GraphData("12", 450),
  GraphData("13", 800),
  GraphData("14", 300),
  GraphData("15", 900),
  GraphData("16", 750),
  GraphData("17", 650),
  GraphData("18", 200),
  GraphData("19", 950),
  GraphData("20", 1600),
  GraphData("21", 1800),
  GraphData("22", 1100),
  GraphData("23", 1000),
  GraphData("24", 950),
  GraphData("25", 500),
  GraphData("26", 600),
  GraphData("27", 650),
  GraphData("28", 360),
  GraphData("29", 100),
  GraphData("30", 300),
];
