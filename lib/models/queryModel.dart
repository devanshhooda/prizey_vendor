class QueryModel {
  String queryId, productId, productName, categoryId;

  QueryModel({this.queryId, this.productId, this.productName, this.categoryId});

  // String get _queryId => this.queryId;
  // String get _productId => this.productId;
  // String get _productName => this.productName;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['query_id'] = queryId;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['category_id'] = categoryId;
    return map;
  }

  QueryModel.fromMapObject(Map<String, dynamic> map) {
    this.queryId = map['query_id'];
    this.productId = map['product_id'];
    this.productName = map['product_name'];
    this.categoryId = map['category_id'];
  }
}
