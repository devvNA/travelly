import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/data/models/responses/login_response_model.dart';
import 'package:travelly/data/models/responses/ticket_response_model.dart';

class OrderResponseModel {
  final String? status;
  final String? message;
  final List<OrderModel>? data;

  OrderResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<OrderModel>.from(
                json["data"]!.map((x) => OrderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderModel {
  final int? id;
  final int? userId;
  final int? eventId;
  final int? quantity;
  final String? totalPrice;
  final DateTime? eventDate;
  final String? statusPayment;
  final String? paymentUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OrderTicket>? orderTickets;
  final UserModel? user;
  final EventModel? event;

  OrderModel({
    this.id,
    this.userId,
    this.eventId,
    this.quantity,
    this.totalPrice,
    this.eventDate,
    this.statusPayment,
    this.paymentUrl,
    this.createdAt,
    this.updatedAt,
    this.orderTickets,
    this.user,
    this.event,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["user_id"],
        eventId: json["event_id"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
        statusPayment: json["status_payment"],
        paymentUrl: json["payment_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderTickets: json["orderTickets"] == null
            ? []
            : List<OrderTicket>.from(
                json["orderTickets"]!.map((x) => OrderTicket.fromJson(x))),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        event:
            json["event"] == null ? null : EventModel.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "event_id": eventId,
        "quantity": quantity,
        "total_price": totalPrice,
        "event_date":
            "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
        "status_payment": statusPayment,
        "payment_url": paymentUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "orderTickets": orderTickets == null
            ? []
            : List<dynamic>.from(orderTickets!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "event": event?.toJson(),
      };
}

class OrderTicket {
  final int? id;
  final int? orderId;
  final int? ticketId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalQuantity;
  final TicketModel? ticket;

  OrderTicket({
    this.id,
    this.orderId,
    this.ticketId,
    this.createdAt,
    this.updatedAt,
    this.totalQuantity,
    this.ticket,
  });

  factory OrderTicket.fromJson(Map<String, dynamic> json) => OrderTicket(
        id: json["id"],
        orderId: json["order_id"],
        ticketId: json["ticket_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalQuantity: json["total_quantity"],
        ticket: json["ticket"] == null
            ? null
            : TicketModel.fromJson(json["ticket"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "ticket_id": ticketId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_quantity": totalQuantity,
        "ticket": ticket?.toJson(),
      };
}
