import 'package:blnk_test/home.dart';
import 'package:blnk_test/model/success.dart';
import 'package:blnk_test/model/user.dart';
import 'package:blnk_test/users_sheets_api.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserInformation extends StatefulWidget {
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  static final String ROUTE_NAME = 'User Information';
  String firstName = '',
      lastName = '',
      email = '',
      city = '',
      landline = '',
      mobileNumber = '',
      town = '',
      frontImage='',
      backImage='',
      nationalId='';
  int bNumber = 0, valid = 1;


  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Repository repo = Repository();

  List<String> _states = ["Choose a state"];
  List<String> _lgas = ["Choose .."];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose ..";
  bool _isLoading = false;

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add your information',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * .92,
                child: Form(
                  key: widget._formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty)return "Please enter your full information";
                              else return null;
                            },
                            initialValue: widget.firstName,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelText: 'First name',
                                labelStyle: TextStyle(color: Colors.grey)),
                            onChanged: (value) {
                              setState(() {
                                widget.firstName = value;
                              });
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty)return "Please enter your full information";
                              else return null;
                            },
                            initialValue: widget.lastName,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelText: 'Last name',
                                labelStyle: TextStyle(color: Colors.grey)),
                            onChanged: (value) {
                              setState(() {
                                widget.lastName = value;
                              });
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty|!value.contains('@'))return "Enter the mail correctly";
                              else return null;
                            },
                            initialValue: widget.email,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelText: 'E-mail',
                                labelStyle: TextStyle(color: Colors.grey)),
                            onChanged: (value) {
                              setState(() {
                                widget.email = value;
                              });
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty)return "Please enter your full information";
                              else return null;
                            },
                            initialValue: widget.city != null ? widget.city : "",
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelText: 'Address',
                                labelStyle: TextStyle(color: Colors.grey)),
                            onChanged: (value) {
                              setState(() {
                                widget.city = value;
                              });
                            },
                          )),
                      SafeArea(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            children: <Widget>[
                              DropdownButton<String>(
                                isExpanded: true,
                                items: _states.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (value) => _onSelectedState(value!),
                                value: _selectedState,
                              ),
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : SizedBox(
                                      height: 20,
                                    ),
                              DropdownButton<String>(

                                isExpanded: true,
                                items: _lgas.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                // onChanged: (value) => print(value),
                                onChanged: (value) => _onSelectedLGA(value!),
                                value: _selectedLGA,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),

                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty)return "Please enter your full information";
                              else return null;
                            },
                            initialValue:
                                widget.landline != null ? widget.landline : "",
                            maxLength: 9,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelText: 'Landline number',
                                labelStyle: TextStyle(color: Colors.grey)),
                            onChanged: (value) {
                              setState(() {
                                widget.landline = value;
                              });
                            },
                          )),

                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: TextFormField(
                            validator: (value){
                              if(value!.isEmpty)return "Please enter your full information";
                              else return null;
                            },
                            initialValue: widget.mobileNumber != null
                                ? widget.mobileNumber
                                : "",
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                labelText: 'Mobile number',
                                labelStyle: TextStyle(color: Colors.grey)),
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                widget.mobileNumber = value;
                              });
                            },
                          )),
                      InkWell(

                        child: Container(
                          width: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFF242366),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Upload your ID',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                            ),
                          ),
                        ),

                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),

                          );
                          widget.nationalId=result[0];
                          widget.frontImage=result[1];
                          widget.backImage=result[2];
                          print(result[0]);
                          print(result[1]);
                          print(result[2]);
                        },

                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF242366),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () async {
                  if(!widget._formkey.currentState!.validate())
                    {return;}

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Uploading"),
                      duration: Duration(seconds: 3),
                    ),

                  );
                  final id = await UserSheetsApi.getRowCount() + 1;
                  print(id);
                  final user = User(id,
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      email: widget.email,
                      address: widget.city,
                      town: _selectedState,
                      area: _selectedLGA,
                      mobileNumber: widget.mobileNumber,
                      landlineNumber: widget.landline,
                      nationalIdFrontImage: widget.frontImage,
                      nationalIdBackImage: widget.backImage,
                      nationalIdNumber: widget.nationalId);
                  await UserSheetsApi.insert([user.toJson()]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Success()),

                  );

                  setState(() {});
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSelectedState(String value) async {
    setState(() {
      _selectedLGA = "Choose ..";
      _selectedState = value;
      _lgas = ["Choose .."];
      _isLoading = true;
    });

    _lgas = List.from(_lgas)..addAll(await repo.getLocalByState(value));

    setState(() {
      _isLoading = false;
    });
  }

  void _onSelectedLGA(String value) {
    setState(
      () => _selectedLGA = value,
    );
  }

}

class Repository {
  List getAll() => _egypt;

  Future<List<String>> getLocalByState(String state) async {
    await Future.delayed(Duration(seconds: 1), () {
      print("Future.delayed");
    });

    return Future.value(_egypt
        .map((map) => StateModel.fromJson(map))
        .where((item) => item.state == state)
        .map((item) => item.lgas)
        .expand((i) => i)
        .toList());
  }

  List<String> getStates() => _egypt
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.state)
      .toList();

  // _nigeria.map((item) => item['state'].toString()).toList();

  List _egypt = [
    {
      "state": "Alexandria",
      "alias": "alexandria",
      "lgas": [
        "Amreya",
        "Ataren",
        "Gomrok",
        "Labban",
        "Mansheya",
        "Montaza",
        "El Raml",
        "North Coast",
        "Bab Sharqi",
        "Borg El Arab",
        "Karmouz",
        "Port al-Basal",
        "Sidi Gaber",
        "Moharam Bek",
      ]
    },
    {
      "state": "Cairo",
      "alias": "cairo",
      "lgas": [
        "15 May City",
        "Abdeen",
        "Ain Shams",
        "Amreya",
        "Azbakeya",
        "El Basatin ",
        "El Gamaliya",
        "El Khalifa",
        "Maadi",
        "El Marg",
        "El Masara",
        "El Matareya",
        "El Mokattam",
        "El Muski",
        "El Nozha",
        "El Shorouk",
        "El Salam",
        "El Sayeda Zeinab",
        "El Tebbin",
        "El Zaher",
        "Zamalek",
        "Zeitoun",
        "Bab El Sharia",
        "Bulaq",
        "Helwan",
        "Nasr City ",
        "Badr City",
        "Heliopolis",
        "Qasr El Nil",
        "Old Cairo",
        "Shubra"
      ]
    },
    {
      "state": "Giza",
      "alias": "giza",
      "lgas": [
        "Dokki",
        "Pyramids",
        "Agouza",
        "El Ayyat",
        "El Badrashein",
        "El Hawamdeya",
        "El Omraniya",
        "El Wahat El Bahariya",
        "El Warraq",
        "Sheikh Zayed City",
        "El Saff",
        "Atfeh",
        "Talbia",
        "Ossim",
        "Bulaq",
        "Imbaba",
        "Kerdasa",
        "6th of October City",
      ]
    },
  ];
}

class StateModel {
  String state = '';
  String alias = '';
  List<String> lgas = [];

  StateModel({required this.state, required this.alias, required this.lgas});

  StateModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    alias = json['alias'];
    lgas = json['lgas'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['alias'] = this.alias;
    data['lgas'] = this.lgas;
    return data;
  }
}
