import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductColorWidget extends StatelessWidget {
  final String? hexColor;
  final int index;

  const ProductColorWidget({
    Key? key,
    required this.hexColor,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return InkResponse(
          radius: 16.0,
          onTap: () {
            productProvider.changeSelectedColorValue(index);
          },
          child: Container(
            width: 32.0,
            height: 32.0,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                color: productProvider.selectedColor == index
                    ? Theme.of(context).accentColor.withOpacity(0.5)
                    : Theme.of(context).scaffoldBackgroundColor,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundColor: HexColor('#$hexColor'),
            ),
          ),
        );
      },
    );
  }
}