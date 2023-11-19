class Product {
  int id;
  String name;
  String? description;
  double costPrice;
  double sellingPrice;
  String quantity;
  String? image;

  Product({
    required this.id,
    required this.name,
     this.description,
    required this.costPrice,
    required this.quantity,
    required this.sellingPrice,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "cost_price": costPrice,
        "selling_price": sellingPrice,
        "quantity": quantity,
        "image": image
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        quantity: json['quantity'],
        costPrice: double.parse(json['cost_price']),
        sellingPrice: double.parse(json['selling_price']),
      );
}
