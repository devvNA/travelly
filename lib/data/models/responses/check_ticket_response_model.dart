class CheckTicketResponseModel {
  final String? status;
  final String? message;
  final bool? isValid;

  CheckTicketResponseModel({
    this.status,
    this.message,
    this.isValid,
  });

  factory CheckTicketResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckTicketResponseModel(
        status: json["status"],
        message: json["message"],
        isValid: json["isValid"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "isValid": isValid,
      };
}
