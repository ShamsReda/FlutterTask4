import 'package:aaa/data/data_source/data_source.dart';
import 'package:aaa/ui/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    if (DataSource.isLoading) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.getData();
        setState(() {
          DataSource.products = data;
          DataSource.isLoading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white54,
        body: DataSource.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: GridView.builder(
                      itemCount: DataSource.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: ProductItem(
                            product: DataSource.products[index],
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    )),
              ));
  }
}
