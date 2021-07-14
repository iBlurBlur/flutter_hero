import 'package:flutter/material.dart';
import 'package:flutter_hero/src/configs/routes/app_route.dart';
import 'package:flutter_hero/src/models/product.dart';
import 'package:flutter_hero/src/pages/home/widgets/product_item.dart';
import 'package:flutter_hero/src/utils/services/network_service.dart';
import 'package:flutter_hero/src/widgets/network_fail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> with AutomaticKeepAliveClientMixin {
  final _spacing = 4.0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _buildFeedNetwork(),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.plus),
        onPressed: () => _navigatorManagementPage(),
      ),
    );
  }

  FutureBuilder _buildFeedNetwork() => FutureBuilder<List<Product>>(
        future: NetworkService().productAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return NetworkFail();
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Product>? products = snapshot.data;
          if (products == null) {
            return Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 22),
              child: Text('No data'),
            );
          }

          return _buildProductGrid(products);
        },
      );

  RefreshIndicator _buildProductGrid(List<Product> products) =>
      RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: GridView.builder(
          padding: EdgeInsets.only(
            left: _spacing,
            right: _spacing,
            top: _spacing,
            bottom: 150,
          ),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: _spacing,
            mainAxisSpacing: _spacing,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductItem(
              product,
              onTap: () => _navigatorManagementPage(product),
            );
          },
        ),
      );

  void _navigatorManagementPage([Product? product]) {
    Navigator.pushNamed(
      context,
      AppRoute.management,
      arguments: product,
    ).then((value) {
      setState(() {});
    });
  }

}
