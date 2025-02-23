class CreateVendorRequestModel {
  final int? userId;
  final String? name;
  final String? description;
  final String? location;
  final String? phone;
  final String? city;

  CreateVendorRequestModel({
    this.userId,
    this.name,
    this.description,
    this.location,
    this.phone,
    this.city,
  });

  factory CreateVendorRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateVendorRequestModel(
        userId: json["user_id"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        phone: json["phone"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "description": description,
        "location": location,
        "phone": phone,
        "city": city,
      };
}
