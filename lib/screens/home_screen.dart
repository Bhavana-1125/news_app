import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                    margin: EdgeInsets.only(left: width * 0.03),
                    child: Text(
                      "Flutter News".toUpperCase(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.8),
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: height * 0.08),
            child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                        blurRadius: 1,
                        color: Colors.grey,
                        offset: Offset(0,2),
                        spreadRadius: 1
                      )]
                    ),
                   // color: Colors.grey,
                    height: height * 0.15,
                    margin: EdgeInsets.only(bottom: height * 0.01, top: height * 0.01, left: width * 0.02, right: width * 0.02),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)
                              ),
                            image: DecorationImage(image: NetworkImage("https://static01.nyt.com/images/2024/05/19/multimedia/19columbia-protestpolitics-01-wmbv/19columbia-protestpolitics-01-wmbv-threeByTwoMediumAt2X.jpg?format=pjpg&quality=75&auto=webp&disable=upscale"),
                            fit: BoxFit.cover)
                          ),
                          width: width * 0.3,
                          height: height * 0.15,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }
}
