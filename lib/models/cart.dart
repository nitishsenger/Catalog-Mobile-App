// import 'dart:ffi';

import 'package:my_flutterapp/models/catalog.dart';
// import 'package:velocity_x/velocity_x.dart';

class CartModel {

  static final cartModel = CartModel._internal();

  CartModel._internal();

  factory CartModel() => cartModel;
  //catalog field
  late CatalogModel _catalog; //ye //private field hai ye

  //collection of ids - store IDs of each item
  final List<int> _itemIds = [];

  //get catalog
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog){
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  //get items in the cart
 List<Item> get items => _itemIds.map((id)=> _catalog.getById(id)).toList();

  //get total price
 num get totalPrice => items.fold(0, (total, current) => total+current.price);

 //add item method
void add(Item item) {
  _itemIds.add(item.id);
}
//remove item method

void remove(Item item) {
  _itemIds.remove(item.id);
}

}