import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:my_flutterapp/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/catalog.dart';


class HomeDetailPage extends StatelessWidget {
  final Item catalog;
  const HomeDetailPage({Key? key, required this.catalog}) :
        assert (catalog!= null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: MyTheme.creamcolor,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$${catalog.price}".text.bold.xl4.red800.make(),
            ElevatedButton(onPressed: (){},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor,
                  ),
                  shape: MaterialStateProperty.all(StadiumBorder(),)
              ),
              child: "Add to Cart".text.color(Colors.white).make(),
            ).wh(130, 50)
          ],
        ).p32(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
                tag: Key(catalog.id.toString()),
                child: Image.network(catalog.image),
            ).h32(context),
            Expanded(child: VxArc(
              height: 30.0,
              arcType: VxArcType.convey,
              edge: VxEdge.top,
              child: Container(
                color: Colors.white,
                width: context.screenWidth,
                child: Column(
                  children: [
                    catalog.name.text.xl4.color(MyTheme.darkBluishColor).bold.make(),
                    catalog.desc.text.textStyle(context.captionStyle).xl.make(),
                    10.heightBox,
                    "Lorem ipsum dolor sit amet. Sed voluptatem natus rem sequi exercitationem et reiciendis dicta aut placeat voluptates. Ut accusantium consequatur eum quaerat perspiciatis quo aliquam nesciunt ea dolorum labore quo obcaecati fugiat? Non incidunt nisi id quod omnis ut sunt dolores qui quaerat dolor aut blanditiis laborum."
                        .text
                        .textStyle(context.captionStyle)
                        .make()
                        .p16(),
                  ],
                ).py64(),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
