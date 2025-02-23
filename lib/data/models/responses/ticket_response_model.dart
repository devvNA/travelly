import 'package:travelly/data/models/responses/event_response_model.dart';

class TicketResponseModel {
  final String? status;
  final List<TicketModel>? data;

  TicketResponseModel({
    this.status,
    this.data,
  });

  factory TicketResponseModel.fromJson(Map<String, dynamic> json) =>
      TicketResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<TicketModel>.from(
                json["data"]!.map((x) => TicketModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TicketModel {
  final int? id;
  final int? skuId;
  final int? eventId;
  final String? ticketCode;
  final DateTime? ticketDate;
  final String? status;
  final SkuModel? sku;
  final EventModel? event;
  TicketModel({
    this.id,
    this.skuId,
    this.eventId,
    this.ticketCode,
    this.ticketDate,
    this.status,
    this.sku,
    this.event,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json["id"],
        skuId: json["sku_id"],
        eventId: json["event_id"],
        ticketCode: json["ticket_code"],
        ticketDate: json["ticket_date"] == null
            ? null
            : DateTime.parse(json["ticket_date"]),
        status: json["status"],
        sku: json["sku"] == null ? null : SkuModel.fromJson(json["sku"]),
        event:
            json["event"] == null ? null : EventModel.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku_id": skuId,
        "event_id": eventId,
        "ticket_code": ticketCode,
        "ticket_date":
            "${ticketDate!.year.toString().padLeft(4, '0')}-${ticketDate!.month.toString().padLeft(2, '0')}-${ticketDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "sku": sku?.toJson(),
        "event": event?.toJson(),
      };
}
