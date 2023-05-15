class Component {
  String? sId;
  String? type;
  String? partNumber;
  String? brand;
  String? model;
  String? rank;
  String? benchmark;
  String? samples;
  String? uRL;

  Component(
      {this.sId,
      this.type,
      this.partNumber,
      this.brand,
      this.model,
      this.rank,
      this.benchmark,
      this.samples,
      this.uRL});

  Component.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['Type'];
    partNumber = json['Part Number'];
    brand = json['Brand'];
    model = json['Model'];
    rank = json['Rank'];
    benchmark = json['Benchmark'];
    samples = json['Samples'];
    uRL = json['URL'];
  }
}
