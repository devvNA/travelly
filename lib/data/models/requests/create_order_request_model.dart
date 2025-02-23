// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateOrderRequestModel {
  final List<OrderDetail>? orderDetails;
  final int? eventId;
  final int? quantity;
  final DateTime? eventDate;

  CreateOrderRequestModel({
    this.orderDetails,
    this.eventId,
    this.quantity,
    this.eventDate,
  });

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequestModel(
        orderDetails: json["order_details"] == null
            ? []
            : List<OrderDetail>.from(
                json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
        eventId: json["event_id"],
        quantity: json["quantity"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
      );

  Map<String, dynamic> toJson() => {
        "order_details": orderDetails == null
            ? []
            : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
        "event_id": eventId,
        "quantity": quantity,
        "event_date":
            "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
      };
}

class OrderDetail {
  final int? skuId;
  final int? qty;

  OrderDetail({
    this.skuId,
    this.qty,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        skuId: json["sku_id"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "sku_id": skuId,
        "qty": qty,
      };
}
