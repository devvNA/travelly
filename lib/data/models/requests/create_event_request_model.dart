import 'package:image_picker/image_picker.dart';

class CreateEventRequestModel {
  final int? vendorId;
  final int? eventCategoryId;
  final String? name;
  final String? description;
  final XFile? image;
  final DateTime? startDate;
  final DateTime? endDate;

  CreateEventRequestModel({
    this.vendorId,
    this.eventCategoryId,
    this.name,
    this.description,
    this.image,
    this.startDate,
    this.endDate,
  });

  factory CreateEventRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateEventRequestModel(
        vendorId: json["vendor_id"],
        eventCategoryId: json["event_category_id"],
        name: json["name"],
        description: json["description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
      );

  Map<String, String> toMap() => {
        "vendor_id": vendorId.toString(),
        "event_category_id": eventCategoryId.toString(),
        "name": name!,
        "description": description!,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
      };
}
