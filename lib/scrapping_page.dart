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
            return StreamBuilder<List<ProductModel>>(
              stream: _.getData(),
              builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<ProductModel> prolist = snapshot.data ??
                      [
                        ProductModel.sampleModel(),
                      ];
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: prolist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  print(
                                    '${prolist[index].title}',
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('${prolist[index].title}'),
                                      content: Text('${prolist[index].price}'),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  elevation: MaterialStateProperty.all(1),
                                  splashFactory: InkSplash.splashFactory,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: Image.network(
                                          '${prolist[index].thumb}',
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text('${prolist[index].title}'),
                                        subtitle: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 1,
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
