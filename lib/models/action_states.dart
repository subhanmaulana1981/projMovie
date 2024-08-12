
class ActionStates {

  // properti(es)
  bool? success;
  int? statusCode;
  String? statusMessage;

  // konstruksi
  ActionStates({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  // method
  ActionStates.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    statusCode = json["status_code"];
    statusMessage = json["status_message"];
  }

}
