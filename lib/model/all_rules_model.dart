
class AllRulesModel {
  String? name;
  String? list;

  AllRulesModel({this.name, this.list});

  AllRulesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    list = json['list'];
  }

 }