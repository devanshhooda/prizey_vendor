class ProductsModel {
  String id;
  String name;
  String imageUrl;

  ProductsModel({this.id, this.name, this.imageUrl});

  ProductsModel.fromJson(Map<String, dynamic> categoriesList)
      : id = categoriesList['_id'],
        name = categoriesList['name'],
        imageUrl = categoriesList['image_url'];
}
