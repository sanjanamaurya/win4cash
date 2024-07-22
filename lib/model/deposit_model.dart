class DepositModel {
  String? cash;
  int? type;
  int? status;
  String? orderId;
  String? createdAt;

  DepositModel(
      {this.cash, this.type, this.status, this.orderId, this.createdAt});

  DepositModel.fromJson(Map<String, dynamic> json) {
    cash = json['cash'];
    type = json['type'];
    status = json['status'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cash'] = this.cash;
    data['type'] = this.type;
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
