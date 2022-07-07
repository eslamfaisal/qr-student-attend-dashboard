class CategoryModel {
  String? id;
  String? image;
  String? name_ar;
  String? name_en;
  double? priority;

  CategoryModel({
    this.id,
    this.name_ar,
    this.name_en,
    this.image,
    this.priority,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name_ar = json['name_ar'];
    name_en = json['name_en'];
    image = json['image'] ?? '';
    priority = double.parse((json['priority'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['image'] = this.image;
    data['name_ar'] = this.name_ar;
    data['name_en'] = this.name_en;
    data['priority'] = this.priority;
    data['updated_at'] = DateTime.now().millisecondsSinceEpoch;
    return data;
  }

}
