class Util {
  static double average(List<double> numbers) {
    return numbers.reduce((a, b) => a + b) / numbers.length;
  }
}
