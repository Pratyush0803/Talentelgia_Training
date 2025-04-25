import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "A",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      size: 12,
                      color: Colors.red,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Onigashima",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Sas Nagar, Mohali, Punjab",
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.bell, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Orders",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Card(
                                      color: Color(0xFFFFF4F4),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              LucideIcons.bellRing,
                                              color: Colors.black54,
                                              size: 35,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Order Alerts",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Card(
                                      color: Color(0xFFFFFBEF),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              LucideIcons.fileBox,
                                              color: Colors.black54,
                                              size: 35,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Open Orders",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Card(
                                      color: Color(0xFFEFF3F9),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              LucideIcons.shoppingBag,
                                              color: Colors.black54,
                                              size: 35,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Open Items",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      color: Colors.white,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Manage Product",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Card(
                                      color: Color(0xFFFFF4F4),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              LucideIcons.alertTriangle,
                                              color: Colors.black54,
                                              size: 35,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Stock Alerts",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  color: Color(0xFFFFFBEF),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 20,
                                      bottom: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          LucideIcons.plusSquare,
                                          color: Colors.black54,
                                          size: 35,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Add Product",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xFFEFF3F9),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 20,
                                      bottom: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          LucideIcons.archive,
                                          color: Colors.black54,
                                          size: 35,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "   Inventory  ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF568CF7),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.barChartBig,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
