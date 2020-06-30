import 'package:breaktimer/breaks/fajosBreak.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'repository/DataRepository.dart';


void main() => runApp(MaterialApp(
    home: Login(),
));

class Fajos extends StatefulWidget {
  @override
  _FajosState createState() => _FajosState();
}

class _FajosState extends State<Fajos> {

  var monit = '';
  var lastFajos = '';

  final DataRepository repository = DataRepository();
  bool isFajosInProgress = false;
  FajosBreak currentFajosBreak;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Break?'),
        centerTitle: true,
        backgroundColor: Colors.green[500],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        setState(() {
                          if(isFajosInProgress == true){
                            var user = getCurrentUser();
                            user.then((userMail){
                              currentFajosBreak.end = new DateTime.now();
                              repository.addBreak(currentFajosBreak);
                              lastFajos = 'Your last fajos ended at ${currentFajosBreak.end}';
                              currentFajosBreak = null;
                              isFajosInProgress = false;
                              lastFajos = 'Your last fajos ended at \n${currentFajosBreak.end}';
                              return monit = 'Fajos is over - kiepos';
                            });
                          }
                          return monit = 'Kiepos - please start fajos';
                          //return monit = 'Fajos';
                        });
                      });
                    },
                    child: Image( image: AssetImage('assets/smoke.png')
                  ),
                  )
                ),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if(isFajosInProgress == false){
                          var user = getCurrentUser();
                          user.then((userMail){
                            currentFajosBreak = FajosBreak(userMail, new DateTime.now());

                            isFajosInProgress = true;
                            return monit = 'Fajos in progress';
                          });
                          }
                          return monit = 'Fajos already in progress';
                          //return monit = 'Fajos';
                        });
                      },
                      child: Image( image: AssetImage('assets/smoke_lit.png')
                      ),
                    )
                ),
                ],
          ),
        Text('$monit'),
        Divider(
            thickness: 2.0,
          ),
        Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              Expanded(
               child: Text(
              '$lastFajos'
              ),
              ),
              ]
        ),
    ],
    ),
    );

  }
}

Future<String> getCurrentUser()  async {
  FirebaseUser _user = await FirebaseAuth.instance.currentUser();
  String userOutput =_user.email ?? "None";
  return userOutput;}


