import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key,required this.itemName,required this.itemPrice,required this.iteamImage});
  final String itemName ;
  final num itemPrice;
  final String iteamImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                child: Image.network(iteamImage,fit: BoxFit.cover),
                decoration: BoxDecoration(

                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName),
                  SizedBox(height: 10),
                  Text("${itemPrice}Dzd")
                ],
              ),
            ],
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)),
            child: Center(child: Text("x1")),
          ),
        ],
      ),
    );
  }
}
