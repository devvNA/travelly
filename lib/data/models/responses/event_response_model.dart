import 'package:travelly/data/models/responses/event_category_response_model.dart';

class EventResponseModel {
  final String? status;
  final List<EventModel>? data;

  EventResponseModel({
    this.status,
    this.data,
  });

  factory EventResponseModel.fromJson(Map<String, dynamic> json) =>
      EventResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<EventModel>.from(
                json["data"]!.map((x) => EventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EventModel {
  final int? id;
  final String? name;
  final String? image;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final Vendor? vendor;
  final EventCategoryModel? eventCategory;
  final List<TicketEventModel>? tickets;

  EventModel({
    this.id,
    this.name,
    this.description,
    this.startDate,
    this.image,
    this.endDate,
    this.vendor,
    this.eventCategory,
    this.tickets,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        eventCategory: json["event_category"] == null
            ? null
            : EventCategoryModel.fromJson(json["event_category"]),
        tickets: json["tickets"] == null
            ? []
            : List<TicketEventModel>.from(
                json["tickets"]!.map((x) => TicketEventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "vendor": vendor?.toJson(),
        "event_category": eventCategory?.toJson(),
        "tickets": tickets == null
            ? []
            : List<dynamic>.from(tickets!.map((x) => x.toJson())),
      };
}

class TicketEventModel {
  final SkuModel? sku;
  final int? ticketCount;

  TicketEventModel({
    this.sku,
    this.ticketCount,
  });

  factory TicketEventModel.fromJson(Map<String, dynamic> json) =>
      TicketEventModel(
        sku: json["sku"] == null ? null : SkuModel.fromJson(json["sku"]),
        ticketCount: json["ticket_count"],
      );

  Map<String, dynamic> toJson() => {
        "sku": sku?.toJson(),
        "ticket_count": ticketCount,
      };
}

class SkuModel {
  final int? id;
  final String? name;
  final String? category;
  final int? eventId;
  final String? price;
  final int? stock;
  final String? dayType;
  final EventModel? event;

  SkuModel({
    this.id,
    this.name,
    this.category,
    this.eventId,
    this.price,
    this.stock,
    this.dayType,
    this.event,
  });

  factory SkuModel.fromJson(Map<String, dynamic> json) => SkuModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        eventId: json["event_id"],
        price: json["price"],
        stock: json["stock"],
        dayType: json["day_type"],
        event:
            json["event"] == null ? null : EventModel.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "event_id": eventId,
        "price": price,
        "stock": stock,
        "day_type": dayType,
        "event": event?.toJson(),
      };
}

class Vendor {
  final int? id;
  final int? userId;
  final String? name;
  final String? location;
  final String? phone;
  final String? email;
  final String? city;
  final String? description;
  final String? verifyStatus;

  Vendor({
    this.id,
    this.userId,
    this.name,
    this.location,
    this.phone,
    this.email,
    this.city,
    this.description,
    this.verifyStatus,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        location: json["location"],
        phone: json["phone"],
        email: json["email"],
        city: json["city"],
        description: json["description"],
        verifyStatus: json["verify_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "location": location,
        "phone": phone,
        "email": email,
        "city": city,
        "description": description,
        "verify_status": verifyStatus,
      };
}
