import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class palf2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xff7a5050),
        items: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Icon(Icons.home),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/chek');
            },
            child: Icon(Icons.add),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Icon(Icons.chat_bubble_outline),
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 1.5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(320.0),
              bottomRight: Radius.circular(320.0),
              topLeft: Radius.circular(320.0),
              topRight: Radius.circular(320.0),
            ),
            border: Border.all(
              color: Color.fromARGB(255, 252, 246, 244),
              width: 4.0,
            ),
          ),
          child: AppBar(
            title: Row(
              children: [
                SizedBox(
                  height: 40.0,
                  child: Image.asset(
                    'lib/img/logoo.png',
                    width: 150.0,
                    height: 100.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  child: Text(
                    'Palfrenier',
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 249, 248),
                      fontSize: 25,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            elevation: 0.0,
            backgroundColor: Color.fromARGB(0, 235, 244, 245),
          ),
        ),
      ),
      body: SingleChildScrollView
      (
        
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Text(
                'Entretien des sabots ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.grey ),
              ),
              Container(
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            child: Text('Produit', style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(83, 121, 85, 72),
                          ),
                        ),
                        TableCell(
                          child: Container(
                           child:  Text('Visite', style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(111, 121, 85, 72),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 40,
                    color: Color.fromARGB(255, 241, 245, 244),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 40,
                            color: Color.fromARGB(255, 255, 255, 253),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height:40),
              Text(
                'Alimentation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.grey),
              ),
              Container(
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            child:    Text('foin', style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(88, 121, 85, 72),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child:    Text('Vitamine', style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(88, 121, 85, 72),
                          ),
                        ),

                        TableCell(
                          child: Container(
                            child:    Text('Bouchon', style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(88, 121, 85, 72),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            child: Text('', style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(228, 241, 245, 244),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 40,
                            color: Color.fromARGB(228, 241, 245, 244),                         child:    Text('', style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 40,
                            color: Color.fromARGB(228, 241, 245, 244),
                            child:    Text('', style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
               SizedBox(height:40),
              Text(
                'Santé',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.grey),
              ),
              Container(
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                         child:    Text('Vaccin', style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(88, 121, 85, 72),
                          ),
                        ),
                        TableCell(
                          child: Container(
                         child:    Text('Visite', style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(88, 121, 85, 72),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            child: Text('', style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                            height: 40,
                            color: Color.fromARGB(255, 241, 245, 244),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 40,
                            color: Color.fromARGB(255, 248, 245, 246),
                          ),
                        ),
                      ],
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
