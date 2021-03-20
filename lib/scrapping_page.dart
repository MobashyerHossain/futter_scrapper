import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_controller.dart';
import 'package:get/get.dart';

class ScrappingPage extends GetView<ScrappingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScrappingPage')),
      body: Container(
        child: GetBuilder<ScrappingController>(
          init: ScrappingController(),
          builder: (_) {
            return FutureBuilder<List<ProductModel>>(
              future: _.getData(),
              builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<ProductModel> prolist = snapshot.data ?? [];
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: prolist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: CachedNetworkImage(
                                      imageUrl: '${prolist[index].thumb}',
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text('${prolist[index].title}'),
                                      subtitle: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        child: Text(
                                          '${prolist[index].price}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _.getPageNum() == 1
                                ? null
                                : () => _.goToPrevPage(),
                            icon: Icon(Icons.chevron_left),
                          ),
                          Text('Page ${_.getPageNum()}'),
                          IconButton(
                            onPressed: prolist.length < 10
                                ? null
                                : () => _.goToNextPage(),
                            icon: Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
