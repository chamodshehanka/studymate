class SubGraphData implements Comparable<SubGraphData> {
  String label;
  int value;

  SubGraphData(this.label, this.value);

  @override
  int compareTo(SubGraphData other) {
    return this.value.compareTo(other.value);
  }
}

List<SubGraphData> dayData = [
  SubGraphData('12AM', 100),
  SubGraphData('3AM', 10),
  SubGraphData('6AM', 180),
  SubGraphData('9AM', 100),
  SubGraphData('12AM', 100),
  SubGraphData('3PM', 90),
  SubGraphData('6PM', 160),
  SubGraphData('9PM', 50),
  SubGraphData('12PM', 80)
];

List<SubGraphData> weekData = [
  SubGraphData('Sunday', 9000),
  SubGraphData('Monday', 1800),
  SubGraphData('Tuesday', 1900),
  SubGraphData('WednesDay', 1300),
  SubGraphData('Thursday', 1500),
  SubGraphData('Friday', 3500),
  SubGraphData('Saturday', 4000),
];

List<SubGraphData> monthData = [
  SubGraphData("01", 200),
  SubGraphData("02", 500),
  SubGraphData("03", 320),
  SubGraphData("04", 490),
  SubGraphData("05", 450),
  SubGraphData("06", 600),
  SubGraphData("07", 650),
  SubGraphData("08", 700),
  SubGraphData("09", 670),
  SubGraphData("10", 350),
  SubGraphData("11", 420),
  SubGraphData("12", 450),
  SubGraphData("13", 800),
  SubGraphData("14", 300),
  SubGraphData("15", 900),
  SubGraphData("16", 750),
  SubGraphData("17", 650),
  SubGraphData("18", 200),
  SubGraphData("19", 950),
  SubGraphData("20", 1600),
  SubGraphData("21", 1800),
  SubGraphData("22", 1100),
  SubGraphData("23", 1000),
  SubGraphData("24", 950),
  SubGraphData("25", 500),
  SubGraphData("26", 600),
  SubGraphData("27", 650),
  SubGraphData("28", 360),
  SubGraphData("29", 100),
  SubGraphData("30", 300),
];
