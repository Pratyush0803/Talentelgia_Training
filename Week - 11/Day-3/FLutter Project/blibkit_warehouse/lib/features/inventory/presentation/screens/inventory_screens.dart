import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFA),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Inventory",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add, weight: 10, size: 30),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      leading: Icon(LucideIcons.search),
                      backgroundColor: WidgetStateProperty.all(
                        Color(0xFFF7FAFA),
                      ),
                      hintText: "Search...",
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(LucideIcons.slidersHorizontal),
                  ),
                ],
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    "Items",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.all(10),
                      height: 100,
                      width: 100,
                      child: Image.network(
                        "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRfyCIV0cgf5plKQiXh6MYAnAvxMoJehhNKFSv11jtzfX-bZM3luCiifJEQ9erwc7VUe_ZGgq5G9VhCsbKlP2vr6NfMkxjBCtgq5C8U4r_VAzoxf24th-9i4A",
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lays",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          "36 in Stock",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        Text(
                          "This is Chips",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      "Price: ₹ 20",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
