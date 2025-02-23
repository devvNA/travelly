class EventCategoryResponseModel {
  final String? status;
  final List<EventCategoryModel>? data;

  EventCategoryResponseModel({
    this.status,
    this.data,
  });

  factory EventCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      EventCategoryResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<EventCategoryModel>.from(
                json["data"]!.map((x) => EventCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EventCategoryModel {
  final int? id;
  final String? name;
  final String? description;

  EventCategoryModel({
    this.id,
    this.name,
    this.description,
  });

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) =>
      EventCategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
