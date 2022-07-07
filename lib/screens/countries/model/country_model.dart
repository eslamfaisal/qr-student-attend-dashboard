class CountryModel {
  String? id;
  String? image;
  String? name_ar;
  String? name_en;
  bool isSelected = false;

  CountryModel({
    this.id,
    this.name_ar,
    this.name_en,
    this.image,
  });

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name_ar = json['name_ar'];
    name_en = json['name_en'];
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['image'] = this.image;
    data['name_ar'] = this.name_ar;
    data['name_en'] = this.name_en;
    data['updated_at'] = DateTime.now().millisecondsSinceEpoch;
    return data;
  }
}
