import 'package:flutter/material.dart';
import 'package:my_flutterapp/models/cart.dart';
import 'package:my_flutterapp/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyTheme.creamcolor,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          Divider(),
          _CardTotal(),
      ],
      ),
    );
  }
}

class _CardTotal extends StatelessWidget {
  const _CardTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final _cart = CartModel();
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "\$${_cart.totalPrice}".text.xl5.color(Colors.deepPurple).make(),
          30.widthBox,
          ElevatedButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "Buying not supported yet.".text.make(),
                ));
              },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor)
            ),
            child: "Buy".text.white.make(),
          ).w32(context)
        ],
      ),
    );
  }
}


class _CartList extends StatefulWidget {
  const _CartList({super.key});

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  final _cart = CartModel();
  @override
  Widget build(BuildContext context) {
    return _cart.items.isEmpty? "Nothing to show".text.xl3.makeCentered(): ListView.builder(
        itemCount: _cart.items?.length,
        itemBuilder: (context,index) => ListTile(
          leading: Icon(Icons.done),
          trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline),
            onPressed: (){
                _cart.remove(_cart.items[index]);
                setState(() {});
            },
          ),
          title: _cart.items[index].name.text.make(),
        )
    );
  }
}

