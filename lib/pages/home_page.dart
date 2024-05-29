import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutterapp/models/cart.dart';
import 'dart:convert';
import 'package:my_flutterapp/models/catalog.dart';
import 'package:my_flutterapp/pages/home_detail_page.dart';
import 'package:my_flutterapp/utils/routes.dart';
// import 'package:my_flutterapp/widgets/drawer.dart';
import 'package:my_flutterapp/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

// import '../widgets/drawer.dart';

//import '../widgets/item_widget.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Codepur";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()   async {
     final catalogJson = await rootBundle.loadString("assets/files/catalog.json");
     final decodedData = jsonDecode(catalogJson);
     var productsData = decodedData["products"];
     CatalogModel.items = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();
     //ye likhna jaruri hai
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    // final _cart = (VxState.store);
    // final dummyList = List.generate(20, (index) => CatalogModel.items[0]);
    // var items;
    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
        backgroundColor: MyTheme.darkBluishColor,
        child:  Icon(CupertinoIcons.cart
        , color: Colors.white),

      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurple,
      //   title: const Text("Catalog Apps Nitish Kumar"),
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //       mainAxisSpacing: 16,
      //       crossAxisSpacing: 16,
      //     ),
      //
      //     itemBuilder: (context , index){
      //       final item = CatalogModel.items[index];
      //       return Card(
      //         clipBehavior: Clip.antiAlias,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: GridTile(
      //             header: Container(
      //               child: Text(item.name, style: TextStyle(color: Colors.white),
      //               ),
      //             padding: const EdgeInsets.all(12),
      //             decoration: BoxDecoration(
      //               color: Colors.deepPurple,
      //             ),
      //             ),
      //               child: Image.network(
      //                   item.image,
      //               ),
      //               footer: Container(
      //                 child: Text(
      //                   item.price.toString(),
      //                   style: TextStyle(color: Colors.white),
      //                 ),
      //                 padding: const EdgeInsets.all(12),
      //                 decoration: BoxDecoration(
      //                   color: Colors.black,
      //                 ),
      //               ),
      //
      //           ));
      //     },
      //
      //       itemCount: CatalogModel.items.length,
      //
      //   ),
      // ),
      // drawer:  MyDrawer(),
      body: SafeArea(  //SafeArea battery area aur niche se andar rakh sakte ho chiz ko
        child: Container(
          padding: Vx.m32, //ye padding dega edgeinsets ka shortcut hai ye
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if(CatalogModel.items!=null && CatalogModel.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                Center(child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),

    );
  }
}


class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.color(MyTheme.darkBluishColor).make(),
        "Trending Products".text.xl2.make(),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=>HomeDetailPage(
                    catalog: catalog
                ),
                ),
          ),
          child: CatalogItem(catalog: catalog),
        );
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;
  const CatalogItem({Key? key , required this.catalog})
      : assert(catalog!=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: Image.network(catalog.image,
            ).box.rounded.p12.color(MyTheme.creamcolor).make().p16().w40(context),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  catalog.name.text.lg.color(MyTheme.darkBluishColor).bold.make(),
                  catalog.desc.text.textStyle(context.captionStyle).make(),
                  10.heightBox,
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonPadding: EdgeInsets.zero,
                    children: [
                      "\$${catalog.price}".text.bold.xl.make(),
                      _AddToCart(catalog:catalog)
                    ],
                  ).pOnly(right: 8.0)
                ],
              ))
        ],
      )
          
    ).white.rounded.square(150).make().py16();
  }
}

class _AddToCart extends StatefulWidget {
 final Item catalog;
  const _AddToCart({
    super.key,required this.catalog,
  });

  @override
  State<_AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<_AddToCart> {
  final _cart = CartModel();

  @override
  Widget build(BuildContext context) {
    bool isInCart = _cart.items.contains(widget.catalog) ?? false;
    return ElevatedButton(onPressed: (){
      isInCart = isInCart.toggle();
      if (!isInCart) {
        isInCart = isInCart.toggle();
        final _catalog = CatalogModel();

        _cart.catalog = _catalog;
        _cart.add(widget.catalog);

        setState(() {});
      }
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor,
      ),
          shape: MaterialStateProperty.all(StadiumBorder(),)
    ),
      child:isInCart ? Icon(Icons.done,color: Colors.white) : Icon(CupertinoIcons.cart_badge_plus ,color: Colors.white ),
    );
  }
}
