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
                          itemCount: prolist.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  child: Image.network(
                                    '${prolist[index].thumb}',
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text('${prolist[index].title}'),
                                    subtitle: Text('${prolist[index].url}'),
                                  ),
                                ),
                              ],
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
