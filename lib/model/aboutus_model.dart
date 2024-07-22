class AboutusModel {
  final String? name;
  final String? description;


  AboutusModel({
    required this.name,
    required this.description,

  });

  factory AboutusModel.fromJson(Map<dynamic, dynamic> json) {
    return AboutusModel(
      name: json['name'],
      description: json['description'],

    );
  }
}
