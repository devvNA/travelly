import 'package:travelly/data/models/responses/login_response_model.dart';

class CreateOrderResponseModel {
  final String? status;
  final String? message;
  final CreateOrder? data;

  CreateOrderResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : CreateOrder.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class CreateOrder {
  final int? userId;
  final int? eventId;
  final DateTime? eventDate;
  final int? quantity;
  final int? totalPrice;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? paymentUrl;
  final UserModel? user;
  final List<Map<String, int>>? orderItems;

  CreateOrder({
    this.userId,
    this.eventId,
    this.eventDate,
    this.quantity,
    this.totalPrice,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.paymentUrl,
    this.user,
    this.orderItems,
  });

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
        userId: json["user_id"],
        eventId: json["event_id"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        paymentUrl: json["payment_url"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        orderItems: json["orderItems"] == null
            ? []
            : List<Map<String, int>>.from(json["orderItems"]!.map(
                (x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "event_id": eventId,
        "event_date":
            "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
        "quantity": quantity,
        "total_price": totalPrice,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "payment_url": paymentUrl,
        "user": user?.toJson(),
        "orderItems": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
