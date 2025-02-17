import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/RoundedIcon.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff7a5050),
          title: Row(
            children: [
              Image.asset(
                'lib/img/logoo.png',
                width: 100.0,
                height: 80.0,
              ),
            ],
          ),
          actions: [
            /*ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29),
              ),
              primary:  Colors.blueGrey,
            ),
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            label: Text(
              'se connecter',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff7a5050),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),*/
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Se connecter',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  //backgroundColor: Color(0xff97bece),
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                ),
                primary: Color.fromARGB(108, 122, 80, 80),
              ),
              icon: Icon(Icons.supervised_user_circle),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              label: Text(
                's\'inscrire',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 252, 251, 249),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: 1.00,
                  //heightFactor:0.00,

                  child: Image.asset(
                    'lib/img/ch.png',
                    height: 750.00,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Bienvenue au Caval-Héros'
                        ''
                        ' Votre club préféré à Monastir !\n\n'
                        'Venez essayez nos spécialités les disciplines de saut'
                        '  '
                        'd\'obstacle, d\'endurance, et de balades à cheval en mer.\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'serif',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30.0),
          Table(
            border: TableBorder.all(
              color: Colors.brown,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      //color: Colors.grey,
                      child: Text('Nom',
                          style: TextStyle(
                            color: Color(0xff7a5050),
                            fontSize: 16,
                            fontFamily: 'serif',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      //color: Colors.grey,
                      child: Text('Role',
                          style: TextStyle(
                            color: Color(0xff7a5050),
                            fontSize: 16,
                            fontFamily: 'serif',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      // color: Colors.grey,
                      child: Text('Robe',
                          style: TextStyle(
                            color: Color(0xff7a5050),
                            fontSize: 16,
                            fontFamily: 'serif',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      // color:  Colors.grey,
                      child: Text(
                          'Année '
                          'naissance',
                          style: TextStyle(
                            color: Color(0xff7a5050),
                            fontSize: 14,
                            fontFamily: 'serif',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Color.fromARGB(255, 252, 251, 251),
                      child: Text('Sam',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Color.fromARGB(255, 252, 250, 250),
                      child: Text('ONC',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Color.fromARGB(255, 248, 248, 248),
                      child: Text('M.Bai',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Color.fromARGB(255, 253, 252, 252),
                      child: Text('2009',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
              TableRow(children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(255, 250, 248, 248),
                    child: Text('Mayouta',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(255, 255, 254, 254),
                    child: Text('ONC',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(255, 252, 251, 251),
                    child: Text('F.gris',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 246, 248, 248),
                    child: Text('2009',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 246, 248, 248),
                    child: Text('Jarray',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(125, 238, 239, 240),
                    child: Text('AR',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(125, 245, 246, 247),
                    child: Text('M.Alezan',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('2015',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('Nahida',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('AB',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('F.Alezan',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('2009',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('Dakota',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('ONC',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('M.Alezan',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('2010',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('Bardok',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Text('ONC',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 251, 251, 252),
                    child: Text('M.Bai',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 250, 251, 252),
                    child: Text('2011',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 248, 250, 252),
                    child: Text('Caranel',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 246, 249, 250),
                    child: Text('ONC',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 250, 251, 252),
                    child: Text('F.Bai',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 246, 247, 248),
                    child: Text('2006',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 239, 242, 243),
                    child: Text('Oréo',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 240, 242, 243),
                    child: Text('AB',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 245, 246, 247),
                    child: Text('M.Alezan',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(126, 248, 249, 250),
                    child: Text('2021',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ])
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(52, 216, 198, 141),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Contactez-nous',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Numéro de téléphone : ',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              '+216 97 831 833',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Suivez-nous sur les réseaux sociaux',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            RoundedIcon(
                              imageUrl: '.idea/img/i.png',
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.facebook),
                              SizedBox(width: 10.0),
                              Text(
                                'Caval-Héros',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            RoundedIcon(
                              imageUrl: '.idea/img/i.png',
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.mail_outlined),
                              SizedBox(width: 10.0),
                              Text(
                                'ClubCavalHéro@gmail.com',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            RoundedIcon(
                              imageUrl: '.idea/img/f.png',
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 10.0),
                              Text(
                                'Monastir ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ])));
  }
}
