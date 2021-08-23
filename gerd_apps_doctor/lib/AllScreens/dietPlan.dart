import 'package:flutter/material.dart';

import 'dietPlanA.dart';
import 'dietPlanB.dart';

class DietPlan extends StatefulWidget {
  DietPlan({Key key}) : super(key: key);

  @override
  _DietPlanState createState() => _DietPlanState();
}

class _DietPlanState extends State<DietPlan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        // jauhkan dari appbar hori = tepi, vertical: atas
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                'Patient Diet Plan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),

              SizedBox(
                height: 30,
              ),

              // section pilih diet plan
              Container(
                // width: size.width * 0.4,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //diet plan A
                        Card(
                          //kotak diet plan
                          child: Container(
                            height: 250,
                            width: 165,
                            //color: Colors.blue,
                            child: Column(
                              //kotak gamba diet plan
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => DietPlanA(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 190,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "images/dietPlanA.png")),
                                        //color: Colors.blueGrey,
                                      )),
                                ),
                                Text(
                                  "Diet Plan A",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // diet Plan B
                        Card(
                          //kotak diet plan
                          child: Container(
                            height: 250,
                            width: 165,
                            //color: Colors.blue,
                            child: Column(
                              //kotak gamba diet plan
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => DietPlanB(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 190,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "images/dietPlanB.png")),
                                        //color: Colors.blueGrey,
                                      )),
                                ),
                                Text(
                                  "Diet Plan B",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
