import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/users.dart';

import 'Suivie.dart';
import 'firebase_options.dart';
import 'validerusers.dart';

class admine extends StatefulWidget {
  @override
  AdminState createState() => AdminState();
}

class AdminState extends State<admine> {
  List<DataRow> _rows = [];

  @override
  initState() {
    super.initState();
    init();
    _fetchData();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('ch2').get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DataRow row = DataRow(
        cells: [
          DataCell(Text(data['nom'].toString())),
          DataCell(Text(data['race'].toString())),
          DataCell(Text(data['robe'].toString())),
          DataCell(Text(data['date naissance'].toString())),
          DataCell(
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FirestoreDataTableSuivie(docId: doc.id.toString())),
                );
                // Button action
                print("");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
              ),
              child: Text('Suivi'),
            ),
          ),
          DataCell(
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('ch2')
                    .doc(doc.id.toString())
                    .delete();
                _fetchData();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown, // Set the desired color here
              ),
              child: Text('Spprimer'),
            ),
          )
        ],
      );
      rows.add(row);
    });

    setState(() {
      _rows = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Row(children: [
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
                  'Administrateur',
                  style: TextStyle(
                    color: Color.fromARGB(255, 252, 249, 248),
                    fontSize: 18,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            elevation: 0.0,
            backgroundColor: Color.fromARGB(0, 235, 244, 245),
          ),
        ),
      ),
      drawer: MyDrawer(),
      // Utilisation du drawer ici
      body: Center(
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.brown,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          child: DataTable(
            columnSpacing: 4,
            horizontalMargin: 4,
            columns: [
              DataColumn(label: Text('Nom')),
              DataColumn(label: Text('Race')),
              DataColumn(label: Text('Robe')),
              DataColumn(label: Text('Date naissance')),
              DataColumn(label: Text('Suivi')),
              DataColumn(label: Text('Supprimer')),
            ],
            rows: _rows,
            dividerThickness: 1.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.brown,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Profil',
                style: TextStyle(color: Colors.white, fontSize: 25)),
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications), // Add the desired icon here
            title: Text('Formulaire des notifications',
                style: TextStyle(color: Colors.black87, fontSize: 18)),
            onTap: () {
              // Naviguer vers le formulaire de notification
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.chat), // Add the desired icon here

            title: Text('Chat',
                style: TextStyle(color: Colors.black87, fontSize: 18)),
            onTap: () {
              // Naviguer vers la page de chat
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserListPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
                Icons.horizontal_split_outlined), // Add the desired icon here

            title: Text('Formulaire des chevaux',
                style: TextStyle(color: Colors.black87, fontSize: 18)),
            onTap: () {
              // Naviguer vers le formulaire de chevaux
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HorseFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
                Icons.person_add_alt_outlined), // Add the desired icon here

            title: Text('Valider utilisateurs',
                style: TextStyle(color: Colors.black87, fontSize: 18)),
            onTap: () {
              // Naviguer vers la page de chat
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => validerusers()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout), // Add the desired icon here

            title: Text('Déconnexion',
                style: TextStyle(color: Colors.black87, fontSize: 18)),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }
}

class NotificationFormPage extends StatelessWidget {
  @override
  final _trainingFormKey = GlobalKey<FormState>();
  final _ridingFormKey = GlobalKey<FormState>();

  final TextEditingController _trainingTimeController = TextEditingController();
  final TextEditingController _trainingDateController = TextEditingController();
  final TextEditingController _trainingHorseNameController =
      TextEditingController();
  final TextEditingController _trainingRiderNameController =
      TextEditingController();

  final TextEditingController _ridingTimeController = TextEditingController();
  final TextEditingController _ridingDateController = TextEditingController();
  final TextEditingController _ridingGroupController = TextEditingController();
  final TextEditingController _ridingTrainerNameController =
      TextEditingController();

  @override
  void dispose() {
    _trainingTimeController.dispose();
    _trainingDateController.dispose();
    _trainingHorseNameController.dispose();
    _trainingRiderNameController.dispose();
    _ridingTimeController.dispose();
    _ridingDateController.dispose();
    _ridingGroupController.dispose();
    _ridingTrainerNameController.dispose();
    //super.dispose();
  }

  void _submitTrainingForm() {
    if (_trainingFormKey.currentState!.validate()) {
      // Traiter les données du formulaire d'entraînement ici
      String trainingTime = _trainingTimeController.text;
      String trainingDate = _trainingDateController.text;
      String trainingHorseName = _trainingHorseNameController.text;
      String trainingRiderName = _trainingRiderNameController.text;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference collection = firestore.collection('training');
      collection.add({
        'time': trainingTime,
        'date': trainingDate,
        'HorseName': trainingHorseName,
        'cavalier': trainingRiderName
      });

      // Afficher les données dans la console (à des fins de démonstration)
      print('Heure d\'entraînement: $trainingTime');
      print('Date d\'entraînement: $trainingDate');
      print('Nom du cheval: $trainingHorseName');
      print('Nom du cavalier: $trainingRiderName');
    }
  }

  void _submitRidingForm() {
    if (_ridingFormKey.currentState!.validate()) {
      // Traiter les données du formulaire de cours ici
      String ridingTime = _ridingTimeController.text;
      String ridingDate = _ridingDateController.text;
      String ridingGroup = _ridingGroupController.text;
      String ridingTrainerName = _ridingTrainerNameController.text;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference collection = firestore.collection('riding');
      collection.add({
        'time': ridingTime,
        'date': ridingDate,
        'group': ridingGroup,
        'entraineur': ridingTrainerName
      });

      // Afficher les données dans la console (à des fins de démonstration)
      print('Heure de cours: $ridingTime');
      print('Date de cours: $ridingDate');
      print('Groupe: $ridingGroup');
      print('Nom de l\'entraîneur: $ridingTrainerName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Row(children: [
          SizedBox(
            height: 40.0,
            child: Image.asset(
              'lib/img/logoo.png',
              width: 140.0,
              height: 120.0,
            ),
          ),
          SizedBox(
              height: 20.0,
              child: Text(
                'Formulaire des notifications',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _trainingFormKey,
                child: Column(
                  children: [
                    Text(
                      'Formulaire d\'entraînement',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _trainingTimeController,
                      decoration: InputDecoration(
                        labelText: 'Heure d\'entraînement',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer l\'heure d\'entraînement';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _trainingDateController,
                      decoration: InputDecoration(
                        labelText: 'Date d\'entraînement',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer la date d\'entraînement';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _trainingHorseNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom du cheval',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer le nom du cheval';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _trainingRiderNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom du cavalier',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer le nom du cavalier';
                        }
                        return null;
                      },
                    ),
                    TextButton(
                      onPressed: _submitTrainingForm,
                      child: Text(
                        'Envoyer',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Form(
                key: _ridingFormKey,
                child: Column(
                  children: [
                    Text(
                      'Formulaire de cours',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _ridingTimeController,
                      decoration: InputDecoration(
                        labelText: 'Heure de cours',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer l\'heure de cours';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ridingDateController,
                      decoration: InputDecoration(
                        labelText: 'Date de cours',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer la date de cours';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ridingGroupController,
                      decoration: InputDecoration(
                        labelText: 'Groupe',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer le groupe';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ridingTrainerNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom de l\'entraîneur',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer le nom de l\'entraîneur';
                        }
                        return null;
                      },
                    ),
                    TextButton(
                      onPressed: _submitRidingForm,
                      child: Text(
                        'Envoyer',
                        style: TextStyle(color: Colors.brown),
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

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('Chat'),
      ),
    );
  }
}

class HorseFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Row(children: [
          SizedBox(
            height: 40.0,
            child: Image.asset(
              'lib/img/logoo.png',
              width: 150.0,
              height: 100.0,
            ),
          ),
          SizedBox(
            child: Text(
              'Formulaire de chevaux',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
      body: HorseForm(),
    );
  }
}

class HorseForm extends StatefulWidget {
  @override
  _HorseFormState createState() => _HorseFormState();
}

class _HorseFormState extends State<HorseForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> dropdownItems = [];
  String selectedValue = "amal chouch";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    setState(() {
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String nom = data['nom'].toString();
        String prenom = data['prenom'].toString();
        String item = prenom + ' ' + nom;
        dropdownItems.add(item);
      });
    });
    print(dropdownItems);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _raceController.dispose();
    _colorController.dispose();
    _birthdateController.dispose();
    _ownerNameController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Traiter les données du formulaire ici
      String horseName = _nameController.text;
      String horseRace = _raceController.text;
      String horseColor = _colorController.text;
      String horseBirthdate = _birthdateController.text;
      String ownerName = _ownerNameController.text;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference ch = firestore.collection('ch2');
      Object dc = ch.add({
        "nom": horseName,
        "race": horseRace,
        "robe": horseColor,
        "date naissance": horseBirthdate,
        "proprietaire": selectedValue
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Cheval creé avec succé"),
            );
          });

      // Afficher les données dans la console (à des fins de démonstration)
      print('Nom du cheval: $horseName');
      print('Race: $horseRace');
      print('Robe: $horseColor');
      print('Date de naissance: $horseBirthdate');
      print('Nom du propriétaire: $ownerName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom du cheval',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer le nom du cheval';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _raceController,
              decoration: InputDecoration(
                labelText: 'Race',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la race du cheval';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _colorController,
              decoration: InputDecoration(
                labelText: 'Robe',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la robe du cheval';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _birthdateController,
              decoration: InputDecoration(
                labelText: 'Date de naissance',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer la date de naissance du cheval';
                }
                return null;
              },
            ),
            DropdownButton<String>(
              value: selectedValue,
              items: dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff7a5050),
              ),
              onPressed: () {
                submitForm();
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}



/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HorseFormPage();
  }
}*/

 

