class ScanModel {
  ScanModel({
    this.id,
    this.value,
  });

  int? id;
  String? value;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
