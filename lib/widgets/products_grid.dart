import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs? productsData.favoriteItems: productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(//create 안 쓰고 value 쓰는 이유: product.dart에서 이미 changenotifier mixin함
        value: products[i], //ChangeNotifierProvider는 child한테 value값 제공함-> product_item.dart에서  final product = Provider.of<Product>(context, listen: false);로 물려받음
        
            child: ProductItem(
                // 이거 변수 지정해서 구분 안 해도 되는 게 product 0,1,2,3 각각 ChangeNotifier로 지정되면서 product_item.dart에서 받는 product(products List 안의 product 요소들 말하는 거임-> 아직 changenotifier되지 않음)가 달라짐->productItem도 달라짐(itemBuilder라서 자바스크립트의 map처럼 provide되는 product를 각각 뿌려줌)
                // products[i].id, products[i].title, products[i].imageUrl),
                )));
  }
}
