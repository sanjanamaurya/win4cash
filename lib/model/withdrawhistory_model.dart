// ignore_for_file: non_constant_identifier_names

class WithdrawModel {
  dynamic amount;
  dynamic type;
  dynamic status;
  dynamic orderId;
  dynamic createdAt;

  WithdrawModel({this.amount, this.type, this.status, this.orderId, this.createdAt});

  WithdrawModel.fromJson(Map<String, dynamic> json) {
  amount = json['amount'];
  type = json['type'];
  status = json['status'];
  orderId = json['order_id'];
  createdAt = json['created_at'];
  }

  }