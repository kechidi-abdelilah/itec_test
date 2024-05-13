import 'package:flutter/material.dart';
import 'package:test_2/api/api_repository.dart';
import 'package:test_2/models/ItemModel.dart';
import 'package:test_2/widgets/itemWidget.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  ApiRepository api = ApiRepository();
  ItemModel items = ItemModel();
  bool loading = true;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    ItemModel? updatedItems = await api.getItems();
    items = updatedItems ?? ItemModel();
    print(updatedItems?.products?.length);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !loading
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shopping",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300)),
                            Text("Cart",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        )
                      ],
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) => ItemWidget(
                          itemName: items.products?[index]?.title ?? "",
                          itemPrice: items.products?[index]?.price ?? 0,
                      iteamImage:items.products?[index]?.thumbnail?? "" ),

                      itemCount: 10 ,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      height: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${items.products?.length ?? 0} items"),
                        Text("650 Dzd")
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () => {},
                        child: Text("Next"),
                        color: Colors.orange,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
