// import 'dart:convert';
class CatalogModel{

  static final catModel = CatalogModel._internal();

  CatalogModel._internal();

  factory CatalogModel() => catModel;

  static List<Item> items = [
    Item(
      id: 1,
      name: "Iphone 12 pro",
      desc: "Apple Iphone 12 generation",
      price: 999,
      color: "#33505a",
      image: "https://media.licdn.com/dms/image/C4E03AQEBtQWtHzQcig/profile-displayphoto-shrink_800_800/0/1618935151669?e=2147483647&v=beta&t=vqOxtAhJc14-FzZ13EYk1YDyeYM4YRPbxj98nOQQSGE",
    )
  ];
  //get item by id
  Item getById(int id) => items.firstWhere((element) => element.id == id, orElse: null);
  //get item by position
  Item getByPosition(int pos) => items[pos];



}

class Item{
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item({required this.id,required this.name,required this.desc,
    required this.price,required this.color,required this.image});//created constructor for the final

  factory Item.fromMap(Map <String,dynamic> map ){
    return Item(
        id: map["id"],
        name: map["name"],
        desc: map["desc"],
        price: map["price"],
        color: map["color"],
        image: map["image"]
    );
  }
  toMap() => {
    id: ["id"],
    name: ["name"],
    desc: ["desc"],
    price: ["price"],
    color: ["color"],
    image: ["image"]
  };
}

final products = [
  Item(
    id: 1,
    name: "Iphone 12 pro",
    desc: "Apple Iphone 12 generation",
    price: 999,
    color: "#33505a",
    image: "https://media.licdn.com/dms/image/C4E03AQEBtQWtHzQcig/profile-displayphoto-shrink_800_800/0/1618935151669?e=2147483647&v=beta&t=vqOxtAhJc14-FzZ13EYk1YDyeYM4YRPbxj98nOQQSGE",
  )
];