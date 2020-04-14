class CategoriesModel {
  String id;
  String name;
  String imageUrl;

  CategoriesModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  CategoriesModel.fromJson(Map<String, dynamic> categoriesList)
      : id = categoriesList['_id'],
        name = categoriesList['name'],
        imageUrl = categoriesList['image_url'];
}
