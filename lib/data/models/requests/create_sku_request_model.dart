class CreateSkuRequestModel {
  final String? name;
  final int? price;
  final String? category;
  final int? eventId;
  final int? stock;
  final String? dayType;

  CreateSkuRequestModel({
    this.name,
    this.price,
    this.category,
    this.eventId,
    this.stock,
    this.dayType,
  });

  factory CreateSkuRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateSkuRequestModel(
        name: json["name"],
        price: json["price"],
        category: json["category"],
        eventId: json["event_id"],
        stock: json["stock"],
        dayType: json["day_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "category": category,
        "event_id": eventId,
        "stock": stock,
        "day_type": dayType,
      };
}
