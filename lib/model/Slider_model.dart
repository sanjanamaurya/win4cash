class SliderModel{
  final String? name;
  final String? image;


  SliderModel({
    this.name,
    this.image,
  });
  factory SliderModel.fromJson(Map<dynamic, dynamic>json){

    return SliderModel(
      name: json["name"],
        image: json["image"],
    );
  }


}
